WITH Stats as (
SELECT
  advanced.Player,
  advanced.Tm as Team,
  advanced.G as games,
  #totals.GS as games_started,
  advanced.MP as Minutes_played,
  advanced.MP/advanced.G as MP_perG,
  advanced.PER as PER,
  advanced.BPM,
  advanced.OBPM,
  advanced.DBPM,
  advanced.VORP,
  totals._3P_ as _3P_pctg,
  totals._2P_ as _2P_pctg,
  totals.FT_ as FT_pctg,
  advanced.WS_48 as WS_48,
  (totals.TOV/totals.AST)/totals.G as TOV_Ass_ratio_perG,
  totals.PF/totals.G as PF_perG,
  advanced.Year as Year
  
FROM `nbachampionsproject.stats.Advanced_2019_2023` as advanced
JOIN `nbachampionsproject.stats.Total_2019_2023` as totals ON totals.Player = advanced.Player and totals.Year = advanced.Year
WHERE
  (advanced.G >5 and advanced.MP/advanced.G >=15.0) or (advanced.G >12 and advanced.MP/advanced.G >=10.0)
),
 avarage_stats as (
SELECT
  adv.Year,
  avg(adv.PER) as PER,
  avg(adv.OBPM) as OBPM,
  avg(adv.DBPM) as DBPM,
  avg(adv.BPM) as BPM,
  avg(adv.VORP) as VORP,
  avg(adv.MP/adv.G) as MP_per_G,
  avg(totals._3P_) as _3P_pctg,
  avg(totals._2P_) as _2P_pctg,
  avg(totals.FT_) as FT_pctg,
  avg(adv.WS_48) as WS_48,
  avg((totals.TOV/totals.AST)/totals.G) as TOV_Ass_ratio_perG,
  avg(totals.PF/totals.G) as PF,
  count(*)
FROM `nbachampionsproject.stats.Advanced_2019_2023` as adv
JOIN `nbachampionsproject.stats.Total_2019_2023` as totals ON totals.Player = adv.Player and totals.Year = adv.Year
WHERE
  (adv.G >5 and adv.MP/adv.G >=15.0) or (adv.G >12 and adv.MP/adv.G >=10.0) 
GROUP BY
  Year
)

SELECT
 *
FROM Stats
JOIN avarage_stats on Stats.Year = avarage_stats.Year

