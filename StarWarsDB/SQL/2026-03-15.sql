-- =============================================================================
-- StarWarsDB – Full Schema Migration
-- Generated: 2026-03-16
-- Run this script to recreate the entire database structure from scratch.
-- =============================================================================


-- =============================================================================
-- EXTENSIONS
-- =============================================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";   -- provides gen_random_uuid()


-- =============================================================================
-- TABLES (in dependency order)
-- =============================================================================

-- ── Independent tables ────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS public.planets (
    id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at      TIMESTAMPTZ NOT NULL    DEFAULT now(),
    name            TEXT        NOT NULL,
    region          TEXT,
    sector          TEXT,
    system          TEXT,
    capital_city    TEXT,
    destinations    TEXT[],
    first_appearance TEXT,
    comments        TEXT
);

CREATE TABLE IF NOT EXISTS public.species (
    id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at      TIMESTAMPTZ NOT NULL    DEFAULT now(),
    name            TEXT        NOT NULL,
    homeworld       UUID        REFERENCES public.planets (id),
    first_appearance TEXT,
    comments        TEXT
);

CREATE TABLE IF NOT EXISTS public.series (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL    DEFAULT now(),
    name        TEXT        NOT NULL,
    source_type TEXT,
    comments    TEXT
);

CREATE TABLE IF NOT EXISTS public.artists (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL    DEFAULT now(),
    name        TEXT        NOT NULL,
    comments    TEXT
);

CREATE TABLE IF NOT EXISTS public.organizations (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL    DEFAULT now(),
    name        TEXT        NOT NULL,
    first_appearance TEXT,
    comments    TEXT
);

CREATE TABLE IF NOT EXISTS public.droids (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL    DEFAULT now(),
    name        TEXT        NOT NULL,
    class_type  TEXT,
    first_appearance TEXT,
    comments    TEXT
);

CREATE TABLE IF NOT EXISTS public.creatures (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL    DEFAULT now(),
    name        TEXT        NOT NULL,
    designation TEXT,
    homeworld   UUID        REFERENCES public.planets (id),
    first_appearance TEXT,
    comments    TEXT
);

CREATE TABLE IF NOT EXISTS public.starship_models (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL    DEFAULT now(),
    name        TEXT        NOT NULL,
    class_type  TEXT,
    line        TEXT,
    first_appearance TEXT,
    comments    TEXT
);

CREATE TABLE IF NOT EXISTS public.misc (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL    DEFAULT now(),
    name        TEXT        NOT NULL,
    first_appearance TEXT,
    comments    TEXT
);

-- ── Tables that depend on series ──────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS public.arcs (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL    DEFAULT now(),
    name        TEXT        NOT NULL,
    serie       UUID        REFERENCES public.series (id),
    comments    TEXT
);

-- ── Tables that depend on series / arcs ───────────────────────────────────────

CREATE TABLE IF NOT EXISTS public.sources (
    id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at       TIMESTAMPTZ NOT NULL    DEFAULT now(),
    name             TEXT,
    serie            UUID        REFERENCES public.series (id),
    number           BIGINT,
    arc              UUID        REFERENCES public.arcs (id),
    era              TEXT,
    source_type      TEXT,
    publication_date DATE        NOT NULL,
    universe_year    BIGINT,
    number_pages     BIGINT,
    is_done          BOOLEAN     NOT NULL    DEFAULT false,
    comments         TEXT
);

-- ── Tables that depend on planets / species ───────────────────────────────────

CREATE TABLE IF NOT EXISTS public.characters (
    id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at      TIMESTAMPTZ NOT NULL    DEFAULT now(),
    name            TEXT        NOT NULL,
    aliases         TEXT[],
    species         UUID        REFERENCES public.species (id),
    homeworld       UUID        REFERENCES public.planets (id),
    gender          TEXT,
    affiliations    UUID[],
    first_appearance TEXT,
    comments        TEXT,
    url             TEXT
);

CREATE TABLE IF NOT EXISTS public.starships (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL    DEFAULT now(),
    name        TEXT        NOT NULL,
    model       UUID        REFERENCES public.starship_models (id),
    first_appearance TEXT,
    comments    TEXT
);

-- ── Facts (depends on sources) ────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS public.facts (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL    DEFAULT now(),
    fact        TEXT        NOT NULL,
    keywords    TEXT[],
    source      UUID        NOT NULL    DEFAULT gen_random_uuid() REFERENCES public.sources (id)
);

-- ── Join / appearance tables ──────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS public.source_characters (
    id          UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    source      UUID    NOT NULL REFERENCES public.sources (id),
    entity      UUID    NOT NULL REFERENCES public.characters (id),
    appearance  INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS public.source_creatures (
    id          UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    source      UUID    NOT NULL REFERENCES public.sources (id),
    entity      UUID    NOT NULL REFERENCES public.creatures (id),
    appearance  INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS public.source_droids (
    id          UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    source      UUID    NOT NULL REFERENCES public.sources (id),
    entity      UUID    NOT NULL REFERENCES public.droids (id),
    appearance  INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS public.source_misc (
    id          UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    source      UUID    NOT NULL REFERENCES public.sources (id),
    entity      UUID    NOT NULL REFERENCES public.misc (id),
    appearance  INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS public.source_organizations (
    id          UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    source      UUID    NOT NULL REFERENCES public.sources (id),
    entity      UUID    NOT NULL REFERENCES public.organizations (id),
    appearance  INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS public.source_planets (
    id          UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
    source      UUID    NOT NULL DEFAULT gen_random_uuid() REFERENCES public.sources (id),
    entity      UUID    NOT NULL DEFAULT gen_random_uuid() REFERENCES public.planets (id),
    appearance  INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS public.source_species (
    id          UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    source      UUID    NOT NULL REFERENCES public.sources (id),
    entity      UUID    NOT NULL REFERENCES public.species (id),
    appearance  INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS public.source_starship_models (
    id          UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    source      UUID    NOT NULL REFERENCES public.sources (id),
    entity      UUID    NOT NULL REFERENCES public.starship_models (id),
    appearance  INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS public.source_starships (
    id          UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    source      UUID    NOT NULL REFERENCES public.sources (id),
    entity      UUID    NOT NULL REFERENCES public.starships (id),
    appearance  INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS public.source_artists (
    id          UUID    PRIMARY KEY DEFAULT gen_random_uuid() UNIQUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    source      UUID    NOT NULL REFERENCES public.sources (id),
    entity      UUID    NOT NULL REFERENCES public.artists (id)
);

CREATE TABLE IF NOT EXISTS public.source_authors (
    id          UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    source      UUID    NOT NULL REFERENCES public.sources (id),
    entity      UUID    NOT NULL REFERENCES public.artists (id)
);


-- =============================================================================
-- ROW LEVEL SECURITY
-- All tables use the same simple policy: authenticated users have full access.
-- =============================================================================

DO $$
DECLARE
    t TEXT;
    tables TEXT[] := ARRAY[
        'arcs','artists','characters','creatures','droids','facts','misc',
        'organizations','planets','series',
        'source_artists','source_authors','source_characters','source_creatures',
        'source_droids','source_misc','source_organizations','source_planets',
        'source_species','source_starship_models','source_starships',
        'sources','species','starship_models','starships'
    ];
BEGIN
    FOREACH t IN ARRAY tables LOOP
        EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY', t);
        -- Drop if exists so this script is idempotent
        EXECUTE format('DROP POLICY IF EXISTS policy ON public.%I', t);
        EXECUTE format(
            'CREATE POLICY policy ON public.%I
             FOR ALL TO authenticated USING (true)', t
        );
    END LOOP;
END;
$$;


-- =============================================================================
-- FUNCTIONS
-- =============================================================================

-- ── load_characters ───────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_characters(input json)
RETURNS TABLE(
    id                  UUID,
    name                TEXT,
    aliases             TEXT[],
    species             JSONB,
    homeworld           JSONB,
    gender              TEXT,
    first_appearance    TEXT,
    comments            TEXT,
    total_appearances   INTEGER,
    series_appearances  INTEGER
)
LANGUAGE plpgsql AS
$function$
DECLARE
    series_id UUID := NULLIF(input->>'series_id', '')::UUID;
    p_filter  TEXT := NULLIF(trim(input->>'filter'), '');
BEGIN
    RAISE NOTICE 'Filter = [%]', p_filter;
    RETURN QUERY
    SELECT
        e.id::UUID,
        e.name,
        e.aliases,
        CASE WHEN x.id IS NOT NULL THEN
            JSON_BUILD_OBJECT(
                'id', x.id,
                'name', x.name,
                'homeworld', CASE WHEN sh.id IS NOT NULL THEN
                    JSON_BUILD_OBJECT(
                        'id', sh.id, 'name', sh.name, 'region', sh.region,
                        'sector', sh.sector, 'system', sh.system,
                        'capital_city', sh.capital_city, 'destinations', sh.destinations,
                        'first_appearance', sh.first_appearance, 'comments', sh.comments
                    ) ELSE NULL END,
                'first_appearance', x.first_appearance,
                'comments', x.comments
            )::JSONB
        ELSE NULL END AS species,
        CASE WHEN h.id IS NOT NULL THEN
            JSON_BUILD_OBJECT(
                'id', h.id, 'name', h.name, 'region', h.region,
                'sector', h.sector, 'system', h.system,
                'capital_city', h.capital_city, 'destinations', h.destinations,
                'first_appearance', h.first_appearance, 'comments', h.comments
            )::JSONB
        ELSE NULL END AS homeworld,
        e.gender,
        e.first_appearance,
        e.comments,
        COUNT(s.id)::INTEGER AS total_appearances,
        COUNT(CASE WHEN sv.serie = series_id THEN s.id ELSE NULL END)::INTEGER AS series_appearances
    FROM characters AS e
    LEFT JOIN source_characters AS s  ON e.id = s.entity
    LEFT JOIN planets           AS h  ON e.homeworld = h.id
    LEFT JOIN species           AS x  ON e.species = x.id
    LEFT JOIN planets           AS sh ON x.homeworld = sh.id
    LEFT JOIN sources           AS sv ON s.source = sv.id
    WHERE
        p_filter IS NULL
        OR e.name ILIKE '%' || p_filter || '%'
        OR EXISTS (
            SELECT 1 FROM unnest(e.aliases) a
            WHERE a ILIKE '%' || p_filter || '%'
        )
    GROUP BY
        e.id, e.name, e.aliases,
        x.id, x.name, sh.id, x.first_appearance, x.comments,
        h.id, h.name, h.region, h.sector, h.system,
        h.capital_city, h.destinations, h.first_appearance, h.comments,
        e.gender, e.first_appearance, e.comments
    ORDER BY series_appearances DESC, total_appearances DESC;
END;
$function$;

-- ── load_creatures ────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_creatures(series_id UUID)
RETURNS TABLE(
    id                  UUID,
    name                TEXT,
    designation         TEXT,
    homeworld           JSONB,
    first_appearance    TEXT,
    comments            TEXT,
    total_appearances   INTEGER,
    series_appearances  INTEGER
)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    SELECT
        e.id::UUID, e.name, e.designation,
        CASE WHEN h.id IS NOT NULL THEN
            JSON_BUILD_OBJECT(
                'id', h.id, 'name', h.name, 'region', h.region,
                'sector', h.sector, 'system', h.system,
                'capital_city', h.capital_city, 'destinations', h.destinations,
                'first_appearance', h.first_appearance, 'comments', h.comments
            )::JSONB
        ELSE NULL END AS homeworld,
        e.first_appearance, e.comments,
        COUNT(s.id)::INTEGER AS total_appearances,
        COUNT(CASE WHEN sv.serie = series_id THEN s.id ELSE NULL END)::INTEGER AS series_appearances
    FROM creatures AS e
    LEFT JOIN source_creatures AS s  ON e.id = s.entity
    LEFT JOIN planets          AS h  ON e.homeworld = h.id
    LEFT JOIN sources          AS sv ON s.source = sv.id
    GROUP BY e.id, e.name, e.designation,
             h.id, h.name, h.region, h.sector, h.system,
             h.capital_city, h.destinations, h.first_appearance, h.comments,
             e.first_appearance, e.comments
    ORDER BY series_appearances DESC, total_appearances DESC;
END;
$function$;

-- ── load_droids ───────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_droids(series_id UUID)
RETURNS TABLE(
    id                  UUID,
    name                TEXT,
    class_type          TEXT,
    first_appearance    TEXT,
    comments            TEXT,
    total_appearances   INTEGER,
    series_appearances  INTEGER
)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    SELECT
        e.id::UUID, e.name, e.class_type, e.first_appearance, e.comments,
        COUNT(s.id)::INTEGER AS total_appearances,
        COUNT(CASE WHEN sv.serie = series_id THEN s.id ELSE NULL END)::INTEGER AS series_appearances
    FROM droids AS e
    LEFT JOIN source_droids AS s  ON e.id = s.entity
    LEFT JOIN sources       AS sv ON s.source = sv.id
    GROUP BY e.id, e.name, e.class_type, e.first_appearance, e.comments
    ORDER BY series_appearances DESC, total_appearances DESC;
END;
$function$;

-- ── load_misc ─────────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_misc(series_id UUID)
RETURNS TABLE(
    id                  UUID,
    name                TEXT,
    first_appearance    TEXT,
    comments            TEXT,
    total_appearances   INTEGER,
    series_appearances  INTEGER
)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    SELECT
        m.id::UUID, m.name, m.first_appearance, m.comments,
        COUNT(s.id)::INTEGER AS total_appearances,
        COUNT(CASE WHEN sm.serie = series_id THEN s.id ELSE NULL END)::INTEGER AS series_appearances
    FROM misc AS m
    LEFT JOIN source_misc AS s  ON m.id = s.entity
    LEFT JOIN sources     AS sm ON s.source = sm.id
    GROUP BY m.id, m.name, m.first_appearance, m.comments
    ORDER BY series_appearances DESC, total_appearances DESC;
END;
$function$;

-- ── load_organizations ────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_organizations(series_id UUID)
RETURNS TABLE(
    id                  UUID,
    name                TEXT,
    first_appearance    TEXT,
    comments            TEXT,
    total_appearances   INTEGER,
    series_appearances  INTEGER
)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    SELECT
        e.id::UUID, e.name, e.first_appearance, e.comments,
        COUNT(s.id)::INTEGER AS total_appearances,
        COUNT(CASE WHEN sv.serie = series_id THEN s.id ELSE NULL END)::INTEGER AS series_appearances
    FROM organizations AS e
    LEFT JOIN source_organizations AS s  ON e.id = s.entity
    LEFT JOIN sources              AS sv ON s.source = sv.id
    GROUP BY e.id, e.name, e.first_appearance, e.comments
    ORDER BY series_appearances DESC, total_appearances DESC;
END;
$function$;

-- ── load_planets ──────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_planets(series_id UUID)
RETURNS TABLE(
    id                  UUID,
    name                TEXT,
    region              TEXT,
    sector              TEXT,
    system              TEXT,
    capital_city        TEXT,
    destinations        TEXT[],
    first_appearance    TEXT,
    comments            TEXT,
    total_appearances   INTEGER,
    series_appearances  INTEGER
)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    SELECT
        e.id::UUID, e.name, e.region, e.sector, e.system,
        e.capital_city, e.destinations, e.first_appearance, e.comments,
        COUNT(s.id)::INTEGER AS total_appearances,
        COUNT(CASE WHEN sv.serie = series_id THEN s.id ELSE NULL END)::INTEGER AS series_appearances
    FROM planets AS e
    LEFT JOIN source_planets AS s  ON e.id = s.entity
    LEFT JOIN sources        AS sv ON s.source = sv.id
    GROUP BY e.id, e.name, e.region, e.sector, e.system,
             e.capital_city, e.destinations, e.first_appearance, e.comments
    ORDER BY series_appearances DESC, total_appearances DESC;
END;
$function$;

-- ── load_species ──────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_species(series_id UUID)
RETURNS TABLE(
    id                  UUID,
    name                TEXT,
    homeworld           JSONB,
    first_appearance    TEXT,
    comments            TEXT,
    total_appearances   INTEGER,
    series_appearances  INTEGER
)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    SELECT
        e.id::UUID, e.name,
        CASE WHEN h.id IS NOT NULL THEN
            JSON_BUILD_OBJECT(
                'id', h.id, 'name', h.name, 'region', h.region,
                'sector', h.sector, 'system', h.system,
                'capital_city', h.capital_city, 'destinations', h.destinations,
                'first_appearance', h.first_appearance, 'comments', h.comments
            )::JSONB
        ELSE NULL END AS homeworld,
        e.first_appearance, e.comments,
        COUNT(s.id)::INTEGER AS total_appearances,
        COUNT(CASE WHEN sv.serie = series_id THEN s.id ELSE NULL END)::INTEGER AS series_appearances
    FROM species AS e
    LEFT JOIN source_species AS s  ON e.id = s.entity
    LEFT JOIN planets        AS h  ON e.homeworld = h.id
    LEFT JOIN sources        AS sv ON s.source = sv.id
    GROUP BY e.id, e.name,
             h.id, h.name, h.region, h.sector, h.system,
             h.capital_city, h.destinations, h.first_appearance, h.comments,
             e.first_appearance, e.comments
    ORDER BY series_appearances DESC, total_appearances DESC;
END;
$function$;

-- ── load_starship_models ──────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_starship_models(series_id UUID)
RETURNS TABLE(
    id                  UUID,
    name                TEXT,
    class_type          TEXT,
    line                TEXT,
    first_appearance    TEXT,
    comments            TEXT,
    total_appearances   INTEGER,
    series_appearances  INTEGER
)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    SELECT
        e.id::UUID, e.name, e.class_type, e.line, e.first_appearance, e.comments,
        COUNT(s.id)::INTEGER AS total_appearances,
        COUNT(CASE WHEN sv.serie = series_id THEN s.id ELSE NULL END)::INTEGER AS series_appearances
    FROM starship_models AS e
    LEFT JOIN source_starship_models AS s  ON e.id = s.entity
    LEFT JOIN sources                AS sv ON s.source = sv.id
    GROUP BY e.id, e.name, e.class_type, e.line, e.first_appearance, e.comments
    ORDER BY series_appearances DESC, total_appearances DESC;
END;
$function$;

-- ── load_starships ────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_starships(series_id UUID)
RETURNS TABLE(
    id                  UUID,
    name                TEXT,
    model               JSONB,
    first_appearance    TEXT,
    comments            TEXT,
    total_appearances   INTEGER,
    series_appearances  INTEGER
)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    SELECT
        e.id::UUID, e.name,
        CASE WHEN m.id IS NOT NULL THEN
            JSON_BUILD_OBJECT(
                'id', m.id, 'name', m.name, 'class_type', m.class_type,
                'line', m.line, 'first_appearance', m.first_appearance,
                'comments', m.comments
            )::JSONB
        ELSE NULL END AS model,
        e.first_appearance, e.comments,
        COUNT(s.id)::INTEGER AS total_appearances,
        COUNT(CASE WHEN sv.serie = series_id THEN s.id ELSE NULL END)::INTEGER AS series_appearances
    FROM starships AS e
    LEFT JOIN source_starships  AS s  ON e.id = s.entity
    LEFT JOIN starship_models   AS m  ON e.model = m.id
    LEFT JOIN sources           AS sv ON s.source = sv.id
    GROUP BY e.id, e.name,
             m.id, m.name, m.class_type, m.line, m.first_appearance, m.comments,
             e.first_appearance, e.comments
    ORDER BY series_appearances DESC, total_appearances DESC;
END;
$function$;

-- ── Helper: reusable source JSONB builder (used in load_source* functions) ─────
-- (inlined directly in each function below — no separate helper needed)

-- ── load_sourcecharacters ─────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_sourcecharacters(source_id UUID)
RETURNS TABLE(id UUID, source JSONB, entity JSONB, appearance INTEGER, nb_appearances INTEGER)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    WITH character_counts AS (
        SELECT source_characters.entity, COUNT(*) AS nb_appearances
        FROM source_characters
        GROUP BY source_characters.entity
    )
    SELECT
        sc.id::UUID,
        JSON_BUILD_OBJECT(
            'id', so.id, 'name', so.name,
            'serie', CASE WHEN s.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', s.id, 'name', s.name, 'comments', s.comments, 'source_type', s.source_type)
                ELSE NULL END,
            'number', so.number,
            'arc', CASE WHEN a.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', a.id, 'name', a.name,
                    'serie', CASE WHEN sa.id IS NOT NULL THEN
                        JSON_BUILD_OBJECT('id', sa.id, 'name', sa.name, 'comments', sa.comments, 'source_type', sa.source_type)
                        ELSE NULL END,
                    'comments', a.comments)
                ELSE NULL END,
            'era', so.era, 'source_type', so.source_type,
            'publication_date', so.publication_date, 'universe_year', so.universe_year,
            'number_pages', so.number_pages, 'is_done', so.is_done, 'comments', so.comments
        )::JSONB AS source,
        JSON_BUILD_OBJECT(
            'id', c.id::UUID, 'name', c.name, 'aliases', c.aliases,
            'species', CASE WHEN x.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', x.id, 'name', x.name,
                    'homeworld', CASE WHEN sh.id IS NOT NULL THEN
                        JSON_BUILD_OBJECT('id', sh.id, 'name', sh.name, 'region', sh.region,
                            'sector', sh.sector, 'system', sh.system, 'capital_city', sh.capital_city,
                            'destinations', sh.destinations, 'first_appearance', sh.first_appearance,
                            'comments', sh.comments)
                        ELSE NULL END,
                    'first_appearance', x.first_appearance, 'comments', x.comments)
                ELSE NULL END,
            'homeworld', CASE WHEN h.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', h.id, 'name', h.name, 'region', h.region,
                    'sector', h.sector, 'system', h.system, 'capital_city', h.capital_city,
                    'destinations', h.destinations, 'first_appearance', h.first_appearance,
                    'comments', h.comments)
                ELSE NULL END,
            'gender', c.gender, 'first_appearance', c.first_appearance, 'comments', c.comments
        )::JSONB AS entity,
        sc.appearance::INTEGER,
        cc.nb_appearances::INTEGER
    FROM source_characters AS sc
    LEFT JOIN characters      AS c  ON sc.entity = c.id
    LEFT JOIN sources         AS so ON sc.source = so.id
    LEFT JOIN series          AS s  ON so.serie = s.id
    LEFT JOIN arcs            AS a  ON so.arc = a.id
    LEFT JOIN series          AS sa ON a.serie = sa.id
    LEFT JOIN planets         AS h  ON c.homeworld = h.id
    LEFT JOIN species         AS x  ON c.species = x.id
    LEFT JOIN planets         AS sh ON x.homeworld = sh.id
    LEFT JOIN character_counts AS cc ON sc.entity = cc.entity
    WHERE sc.source = source_id;
END;
$function$;

-- ── load_sourcecreatures ──────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_sourcecreatures(source_id UUID)
RETURNS TABLE(id UUID, source JSONB, entity JSONB, appearance INTEGER, nb_appearances INTEGER)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    WITH creature_counts AS (
        SELECT source_creatures.entity, COUNT(*) AS nb_appearances
        FROM source_creatures GROUP BY source_creatures.entity
    )
    SELECT
        sc.id::UUID,
        JSON_BUILD_OBJECT(
            'id', so.id, 'name', so.name,
            'serie', CASE WHEN s.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', s.id, 'name', s.name, 'comments', s.comments, 'source_type', s.source_type)
                ELSE NULL END,
            'number', so.number,
            'arc', CASE WHEN a.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', a.id, 'name', a.name,
                    'serie', CASE WHEN sa.id IS NOT NULL THEN
                        JSON_BUILD_OBJECT('id', sa.id, 'name', sa.name, 'comments', sa.comments, 'source_type', sa.source_type)
                        ELSE NULL END,
                    'comments', a.comments)
                ELSE NULL END,
            'era', so.era, 'source_type', so.source_type,
            'publication_date', so.publication_date, 'universe_year', so.universe_year,
            'number_pages', so.number_pages, 'is_done', so.is_done, 'comments', so.comments
        )::JSONB AS source,
        JSON_BUILD_OBJECT(
            'id', c.id::UUID, 'name', c.name, 'designation', c.designation,
            'homeworld', CASE WHEN h.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', h.id, 'name', h.name, 'region', h.region,
                    'sector', h.sector, 'system', h.system, 'capital_city', h.capital_city,
                    'destinations', h.destinations, 'first_appearance', h.first_appearance,
                    'comments', h.comments)
                ELSE NULL END,
            'first_appearance', c.first_appearance, 'comments', c.comments
        )::JSONB AS entity,
        sc.appearance::INTEGER,
        cc.nb_appearances::INTEGER
    FROM source_creatures AS sc
    LEFT JOIN creatures       AS c  ON sc.entity = c.id
    LEFT JOIN sources         AS so ON sc.source = so.id
    LEFT JOIN series          AS s  ON so.serie = s.id
    LEFT JOIN arcs            AS a  ON so.arc = a.id
    LEFT JOIN series          AS sa ON a.serie = sa.id
    LEFT JOIN planets         AS h  ON c.homeworld = h.id
    LEFT JOIN creature_counts AS cc ON sc.entity = cc.entity
    WHERE sc.source = source_id;
END;
$function$;

-- ── load_sourcedroids ─────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_sourcedroids(source_id UUID)
RETURNS TABLE(id UUID, source JSONB, entity JSONB, appearance INTEGER, nb_appearances INTEGER)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    WITH droid_counts AS (
        SELECT source_droids.entity, COUNT(*) AS nb_appearances
        FROM source_droids GROUP BY source_droids.entity
    )
    SELECT
        sc.id::UUID,
        JSON_BUILD_OBJECT(
            'id', so.id, 'name', so.name,
            'serie', CASE WHEN s.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', s.id, 'name', s.name, 'comments', s.comments, 'source_type', s.source_type)
                ELSE NULL END,
            'number', so.number,
            'arc', CASE WHEN a.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', a.id, 'name', a.name,
                    'serie', CASE WHEN sa.id IS NOT NULL THEN
                        JSON_BUILD_OBJECT('id', sa.id, 'name', sa.name, 'comments', sa.comments, 'source_type', sa.source_type)
                        ELSE NULL END,
                    'comments', a.comments)
                ELSE NULL END,
            'era', so.era, 'source_type', so.source_type,
            'publication_date', so.publication_date, 'universe_year', so.universe_year,
            'number_pages', so.number_pages, 'is_done', so.is_done, 'comments', so.comments
        )::JSONB AS source,
        JSON_BUILD_OBJECT(
            'id', c.id::UUID, 'name', c.name, 'class_type', c.class_type,
            'first_appearance', c.first_appearance, 'comments', c.comments
        )::JSONB AS entity,
        sc.appearance::INTEGER,
        cc.nb_appearances::INTEGER
    FROM source_droids AS sc
    LEFT JOIN droids       AS c  ON sc.entity = c.id
    LEFT JOIN sources      AS so ON sc.source = so.id
    LEFT JOIN series       AS s  ON so.serie = s.id
    LEFT JOIN arcs         AS a  ON so.arc = a.id
    LEFT JOIN series       AS sa ON a.serie = sa.id
    LEFT JOIN droid_counts AS cc ON sc.entity = cc.entity
    WHERE sc.source = source_id;
END;
$function$;

-- ── load_sourcemisc ───────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_sourcemisc(source_id UUID)
RETURNS TABLE(id UUID, source JSONB, entity JSONB, appearance INTEGER, nb_appearances INTEGER)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    WITH misc_counts AS (
        SELECT source_misc.entity, COUNT(*) AS nb_appearances
        FROM source_misc GROUP BY source_misc.entity
    )
    SELECT
        sc.id::UUID,
        JSON_BUILD_OBJECT(
            'id', so.id, 'name', so.name,
            'serie', CASE WHEN s.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', s.id, 'name', s.name, 'comments', s.comments, 'source_type', s.source_type)
                ELSE NULL END,
            'number', so.number,
            'arc', CASE WHEN a.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', a.id, 'name', a.name,
                    'serie', CASE WHEN sa.id IS NOT NULL THEN
                        JSON_BUILD_OBJECT('id', sa.id, 'name', sa.name, 'comments', sa.comments, 'source_type', sa.source_type)
                        ELSE NULL END,
                    'comments', a.comments)
                ELSE NULL END,
            'era', so.era, 'source_type', so.source_type,
            'publication_date', so.publication_date, 'universe_year', so.universe_year,
            'number_pages', so.number_pages, 'is_done', so.is_done, 'comments', so.comments
        )::JSONB AS source,
        JSON_BUILD_OBJECT(
            'id', c.id::UUID, 'name', c.name,
            'first_appearance', c.first_appearance, 'comments', c.comments
        )::JSONB AS entity,
        sc.appearance::INTEGER,
        cc.nb_appearances::INTEGER
    FROM source_misc AS sc
    LEFT JOIN misc        AS c  ON sc.entity = c.id
    LEFT JOIN sources     AS so ON sc.source = so.id
    LEFT JOIN series      AS s  ON so.serie = s.id
    LEFT JOIN arcs        AS a  ON so.arc = a.id
    LEFT JOIN series      AS sa ON a.serie = sa.id
    LEFT JOIN misc_counts AS cc ON sc.entity = cc.entity
    WHERE sc.source = source_id;
END;
$function$;

-- ── load_sourceorganizations ──────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_sourceorganizations(source_id UUID)
RETURNS TABLE(id UUID, source JSONB, entity JSONB, appearance INTEGER, nb_appearances INTEGER)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    WITH organization_counts AS (
        SELECT source_organizations.entity, COUNT(*) AS nb_appearances
        FROM source_organizations GROUP BY source_organizations.entity
    )
    SELECT
        sc.id::UUID,
        JSON_BUILD_OBJECT(
            'id', so.id, 'name', so.name,
            'serie', CASE WHEN s.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', s.id, 'name', s.name, 'comments', s.comments, 'source_type', s.source_type)
                ELSE NULL END,
            'number', so.number,
            'arc', CASE WHEN a.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', a.id, 'name', a.name,
                    'serie', CASE WHEN sa.id IS NOT NULL THEN
                        JSON_BUILD_OBJECT('id', sa.id, 'name', sa.name, 'comments', sa.comments, 'source_type', sa.source_type)
                        ELSE NULL END,
                    'comments', a.comments)
                ELSE NULL END,
            'era', so.era, 'source_type', so.source_type,
            'publication_date', so.publication_date, 'universe_year', so.universe_year,
            'number_pages', so.number_pages, 'is_done', so.is_done, 'comments', so.comments
        )::JSONB AS source,
        JSON_BUILD_OBJECT(
            'id', c.id::UUID, 'name', c.name,
            'first_appearance', c.first_appearance, 'comments', c.comments
        )::JSONB AS entity,
        sc.appearance::INTEGER,
        cc.nb_appearances::INTEGER
    FROM source_organizations AS sc
    LEFT JOIN organizations        AS c  ON sc.entity = c.id
    LEFT JOIN sources              AS so ON sc.source = so.id
    LEFT JOIN series               AS s  ON so.serie = s.id
    LEFT JOIN arcs                 AS a  ON so.arc = a.id
    LEFT JOIN series               AS sa ON a.serie = sa.id
    LEFT JOIN organization_counts  AS cc ON sc.entity = cc.entity
    WHERE sc.source = source_id;
END;
$function$;

-- ── load_sourceplanets ────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_sourceplanets(source_id UUID)
RETURNS TABLE(id UUID, source JSONB, entity JSONB, appearance INTEGER, nb_appearances INTEGER)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    WITH planet_counts AS (
        SELECT source_planets.entity, COUNT(*) AS nb_appearances
        FROM source_planets GROUP BY source_planets.entity
    )
    SELECT
        sc.id::UUID,
        JSON_BUILD_OBJECT(
            'id', so.id, 'name', so.name,
            'serie', CASE WHEN s.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', s.id, 'name', s.name, 'comments', s.comments, 'source_type', s.source_type)
                ELSE NULL END,
            'number', so.number,
            'arc', CASE WHEN a.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', a.id, 'name', a.name,
                    'serie', CASE WHEN sa.id IS NOT NULL THEN
                        JSON_BUILD_OBJECT('id', sa.id, 'name', sa.name, 'comments', sa.comments, 'source_type', sa.source_type)
                        ELSE NULL END,
                    'comments', a.comments)
                ELSE NULL END,
            'era', so.era, 'source_type', so.source_type,
            'publication_date', so.publication_date, 'universe_year', so.universe_year,
            'number_pages', so.number_pages, 'is_done', so.is_done, 'comments', so.comments
        )::JSONB AS source,
        JSON_BUILD_OBJECT(
            'id', c.id::UUID, 'name', c.name, 'region', c.region,
            'sector', c.sector, 'system', c.system, 'capital_city', c.capital_city,
            'destinations', c.destinations, 'first_appearance', c.first_appearance,
            'comments', c.comments
        )::JSONB AS entity,
        sc.appearance::INTEGER,
        cc.nb_appearances::INTEGER
    FROM source_planets AS sc
    LEFT JOIN planets       AS c  ON sc.entity = c.id
    LEFT JOIN sources       AS so ON sc.source = so.id
    LEFT JOIN series        AS s  ON so.serie = s.id
    LEFT JOIN arcs          AS a  ON so.arc = a.id
    LEFT JOIN series        AS sa ON a.serie = sa.id
    LEFT JOIN planet_counts AS cc ON sc.entity = cc.entity
    WHERE sc.source = source_id;
END;
$function$;

-- ── load_sourcespecies ────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_sourcespecies(source_id UUID)
RETURNS TABLE(id UUID, source JSONB, entity JSONB, appearance INTEGER, nb_appearances INTEGER)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    WITH species_counts AS (
        SELECT source_species.entity, COUNT(*) AS nb_appearances
        FROM source_species GROUP BY source_species.entity
    )
    SELECT
        sc.id::UUID,
        JSON_BUILD_OBJECT(
            'id', so.id, 'name', so.name,
            'serie', CASE WHEN s.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', s.id, 'name', s.name, 'comments', s.comments, 'source_type', s.source_type)
                ELSE NULL END,
            'number', so.number,
            'arc', CASE WHEN a.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', a.id, 'name', a.name,
                    'serie', CASE WHEN sa.id IS NOT NULL THEN
                        JSON_BUILD_OBJECT('id', sa.id, 'name', sa.name, 'comments', sa.comments, 'source_type', sa.source_type)
                        ELSE NULL END,
                    'comments', a.comments)
                ELSE NULL END,
            'era', so.era, 'source_type', so.source_type,
            'publication_date', so.publication_date, 'universe_year', so.universe_year,
            'number_pages', so.number_pages, 'is_done', so.is_done, 'comments', so.comments
        )::JSONB AS source,
        JSON_BUILD_OBJECT(
            'id', c.id::UUID, 'name', c.name,
            'homeworld', CASE WHEN h.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', h.id, 'name', h.name, 'region', h.region,
                    'sector', h.sector, 'system', h.system, 'capital_city', h.capital_city,
                    'destinations', h.destinations, 'first_appearance', h.first_appearance,
                    'comments', h.comments)
                ELSE NULL END,
            'first_appearance', c.first_appearance, 'comments', c.comments
        )::JSONB AS entity,
        sc.appearance::INTEGER,
        cc.nb_appearances::INTEGER
    FROM source_species AS sc
    LEFT JOIN species        AS c  ON sc.entity = c.id
    LEFT JOIN sources        AS so ON sc.source = so.id
    LEFT JOIN series         AS s  ON so.serie = s.id
    LEFT JOIN arcs           AS a  ON so.arc = a.id
    LEFT JOIN series         AS sa ON a.serie = sa.id
    LEFT JOIN planets        AS h  ON c.homeworld = h.id
    LEFT JOIN species_counts AS cc ON sc.entity = cc.entity
    WHERE sc.source = source_id;
END;
$function$;

-- ── load_sourcestarshipmodels ─────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_sourcestarshipmodels(source_id UUID)
RETURNS TABLE(id UUID, source JSONB, entity JSONB, appearance INTEGER, nb_appearances INTEGER)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    WITH starshipmodel_counts AS (
        SELECT source_starship_models.entity, COUNT(*) AS nb_appearances
        FROM source_starship_models GROUP BY source_starship_models.entity
    )
    SELECT
        sc.id::UUID,
        JSON_BUILD_OBJECT(
            'id', so.id, 'name', so.name,
            'serie', CASE WHEN s.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', s.id, 'name', s.name, 'comments', s.comments, 'source_type', s.source_type)
                ELSE NULL END,
            'number', so.number,
            'arc', CASE WHEN a.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', a.id, 'name', a.name,
                    'serie', CASE WHEN sa.id IS NOT NULL THEN
                        JSON_BUILD_OBJECT('id', sa.id, 'name', sa.name, 'comments', sa.comments, 'source_type', sa.source_type)
                        ELSE NULL END,
                    'comments', a.comments)
                ELSE NULL END,
            'era', so.era, 'source_type', so.source_type,
            'publication_date', so.publication_date, 'universe_year', so.universe_year,
            'number_pages', so.number_pages, 'is_done', so.is_done, 'comments', so.comments
        )::JSONB AS source,
        JSON_BUILD_OBJECT(
            'id', c.id::UUID, 'name', c.name, 'class_type', c.class_type,
            'line', c.line, 'first_appearance', c.first_appearance, 'comments', c.comments
        )::JSONB AS entity,
        sc.appearance::INTEGER,
        cc.nb_appearances::INTEGER
    FROM source_starship_models AS sc
    LEFT JOIN starship_models       AS c  ON sc.entity = c.id
    LEFT JOIN sources               AS so ON sc.source = so.id
    LEFT JOIN series                AS s  ON so.serie = s.id
    LEFT JOIN arcs                  AS a  ON so.arc = a.id
    LEFT JOIN series                AS sa ON a.serie = sa.id
    LEFT JOIN starshipmodel_counts  AS cc ON sc.entity = cc.entity
    WHERE sc.source = source_id;
END;
$function$;

-- ── load_sourcestarships ──────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.load_sourcestarships(source_id UUID)
RETURNS TABLE(id UUID, source JSONB, entity JSONB, appearance INTEGER, nb_appearances INTEGER)
LANGUAGE plpgsql AS
$function$
BEGIN
    RETURN QUERY
    WITH starship_counts AS (
        SELECT source_starships.entity, COUNT(*) AS nb_appearances
        FROM source_starships GROUP BY source_starships.entity
    )
    SELECT
        sc.id::UUID,
        JSON_BUILD_OBJECT(
            'id', so.id, 'name', so.name,
            'serie', CASE WHEN s.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', s.id, 'name', s.name, 'comments', s.comments, 'source_type', s.source_type)
                ELSE NULL END,
            'number', so.number,
            'arc', CASE WHEN a.id IS NOT NULL THEN
                JSON_BUILD_OBJECT('id', a.id, 'name', a.name,
                    'serie', CASE WHEN sa.id IS NOT NULL THEN
                        JSON_BUILD_OBJECT('id', sa.id, 'name', sa.name, 'comments', sa.comments, 'source_type', sa.source_type)
                        ELSE NULL END,
                    'comments', a.comments)
                ELSE NULL END,
            'era', so.era, 'source_type', so.source_type,
            'publication_date', so.publication_date, 'universe_year', so.universe_year,
            'number_pages', so.number_pages, 'is_done', so.is_done, 'comments', so.comments
        )::JSONB AS source,
        JSON_BUILD_OBJECT(
            'id', c.id::UUID, 'name', c.name,
            'model', CASE WHEN m.id IS NOT NULL THEN
                JSON_BUILD_OBJECT(
                    'id', m.id, 'name', m.name, 'class_type', m.class_type,
                    'line', m.line, 'first_appearance', m.first_appearance, 'comments', m.comments
                )::JSONB
            ELSE NULL END,
            'first_appearance', c.first_appearance, 'comments', c.comments
        )::JSONB AS entity,
        sc.appearance::INTEGER,
        cc.nb_appearances::INTEGER
    FROM source_starships AS sc
    LEFT JOIN starships       AS c  ON sc.entity = c.id
    LEFT JOIN sources         AS so ON sc.source = so.id
    LEFT JOIN series          AS s  ON so.serie = s.id
    LEFT JOIN arcs            AS a  ON so.arc = a.id
    LEFT JOIN series          AS sa ON a.serie = sa.id
    LEFT JOIN starship_models AS m  ON c.model = m.id
    LEFT JOIN starship_counts AS cc ON sc.entity = cc.entity
    WHERE sc.source = source_id;
END;
$function$;

-- ── test_filter (utility / dev function) ──────────────────────────────────────
CREATE OR REPLACE FUNCTION public.test_filter(input JSONB)
RETURNS TABLE(name TEXT)
LANGUAGE plpgsql AS
$function$
DECLARE
    p_filter TEXT := NULLIF(trim(input->>'filter'), '');
BEGIN
    RAISE NOTICE 'p_filter = [%]', p_filter;
    RETURN QUERY
    SELECT e.name
    FROM characters AS e
    WHERE p_filter IS NULL
       OR e.name ILIKE '%' || p_filter || '%';
END;
$function$;
