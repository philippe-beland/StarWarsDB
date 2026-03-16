-- =============================================================================
-- StarWarsDB – Migration 2026-03-16
-- Add load_artists and load_authors functions for frequency-based ordering
-- =============================================================================

-- ── load_artists ─────────────────────────────────────────────────────────────
-- Returns artists sorted by most frequent appearances in sources.
-- When a series_id is provided, artists appearing in that series sort first.
CREATE OR REPLACE FUNCTION public.load_artists(series_id UUID)
RETURNS TABLE(
    id                  UUID,
    name                TEXT,
    comments            TEXT,
    total_appearances   INTEGER,
    series_appearances  INTEGER
)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    SELECT
        a.id::UUID, a.name, a.comments,
        COUNT(sa.id)::INTEGER AS total_appearances,
        COUNT(CASE WHEN sv.serie = series_id THEN sa.id ELSE NULL END)::INTEGER AS series_appearances
    FROM artists AS a
    LEFT JOIN source_artists AS sa ON a.id = sa.entity
    LEFT JOIN sources        AS sv ON sa.source = sv.id
    GROUP BY a.id, a.name, a.comments
    ORDER BY series_appearances DESC, total_appearances DESC;
END;
$function$;

-- ── load_authors ─────────────────────────────────────────────────────────────
-- Returns authors (from the artists table, via source_authors join) sorted by
-- most frequent appearances in sources.
-- When a series_id is provided, authors appearing in that series sort first.
CREATE OR REPLACE FUNCTION public.load_authors(series_id UUID)
RETURNS TABLE(
    id                  UUID,
    name                TEXT,
    comments            TEXT,
    total_appearances   INTEGER,
    series_appearances  INTEGER
)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    SELECT
        a.id::UUID, a.name, a.comments,
        COUNT(sa.id)::INTEGER AS total_appearances,
        COUNT(CASE WHEN sv.serie = series_id THEN sa.id ELSE NULL END)::INTEGER AS series_appearances
    FROM artists AS a
    LEFT JOIN source_authors AS sa ON a.id = sa.entity
    LEFT JOIN sources        AS sv ON sa.source = sv.id
    GROUP BY a.id, a.name, a.comments
    ORDER BY series_appearances DESC, total_appearances DESC;
END;
$function$;
