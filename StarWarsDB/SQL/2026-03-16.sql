-- =============================================================================
-- StarWarsDB – Migration 2026-03-16
-- Add load_artists and load_authors functions for frequency-based ordering.
-- Each function only returns people who have at least one record in their
-- respective join table (source_artists / source_authors), so artists and
-- authors are properly distinguished even though they share the artists table.
-- =============================================================================

-- ── load_artists ─────────────────────────────────────────────────────────────
-- Returns only people who have been assigned as artists (exist in source_artists).
-- Sorted by series appearances first, then total appearances.
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
    INNER JOIN source_artists AS sa ON a.id = sa.entity
    LEFT  JOIN sources        AS sv ON sa.source = sv.id
    GROUP BY a.id, a.name, a.comments
    ORDER BY series_appearances DESC, total_appearances DESC;
END;
$function$;

-- ── load_authors ─────────────────────────────────────────────────────────────
-- Returns only people who have been assigned as authors (exist in source_authors).
-- Sorted by series appearances first, then total appearances.
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
    INNER JOIN source_authors AS sa ON a.id = sa.entity
    LEFT  JOIN sources        AS sv ON sa.source = sv.id
    GROUP BY a.id, a.name, a.comments
    ORDER BY series_appearances DESC, total_appearances DESC;
END;
$function$;
