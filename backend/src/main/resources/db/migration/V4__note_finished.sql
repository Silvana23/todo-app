ALTER TABLE notes ADD finished BOOLEAN DEFAULT false;

ALTER TABLE notes ALTER COLUMN finished SET NOT NULL;