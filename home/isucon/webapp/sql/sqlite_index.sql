CREATE INDEX player_score_idx1 ON player_score (tenant_id, competition_id, player_id, row_num DESC);
CREATE INDEX player_score_idx2 ON player_score (tenant_id, competition_id, row_num DESC);
CREATE INDEX competition_idx1 ON competition (tenant_id, created_at DESC);
CREATE INDEX player_idx1 ON player (tenant_id, created_at);

