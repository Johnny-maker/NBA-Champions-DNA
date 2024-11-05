SELECT
  adv.Year,
  avg(adv.PER) as PER,
  avg(adv.OBPM) as OBPM,
  avg(adv.DBPM) as DBPM,
  avg(adv.BPM) as BPM,
  avg(adv.VORP) as VORP,
  #avg(adv.MP/adv.G) as MP_per_G,
  avg(totals._3P_) as _3P_pctg,
  avg(totals._2P_) as _2P_pctg,
  avg(totals.FT_) as FT_pctg,
  avg(adv.WS_48) as WS_48,
  avg(totals.TOV) as TOV,
  avg(totals.PF) as PF,
  count(*)
FROM `nbachampionsproject.stats.Advanced_2019_2023` as adv
JOIN `nbachampionsproject.stats.Total_2019_2023` as totals ON totals.Player = adv.Player and totals.Year = adv.Year
WHERE
  adv.G >= 5 and adv.MP/adv.G >= 15.0
GROUP BY
  Year
Order By
  Year DESC
