WITH quartis as(
SELECT 
  Player,
  Year,
  Team,
  ntile(10) over ( partition by Year order by Pt_min) as quartile_pt,
  ntile(10) over ( partition by Year order by PER) as quartile_PER,
  ntile(10) over ( partition by Year order by Ast_min) as quartile_Ast,
  ntile(10) over ( partition by Year  order by ORB_min) as quartile_ORB,
  ntile(10) over ( partition by Year  order by DRB_min) as quartile_DRB,
  ntile(10) over ( partition by Year  order by BlK_min) as quartile_Blk,
  ntile(10) over ( partition by Year  order by Stl_min) as quartile_STL,
  ntile(10) over ( partition by Year  order by TOV_min) as quartile_TOV,
  ntile(10) over ( partition by Year  order by Ast_Tov_ratio) as quartile_Ast_TOV,
  ntile(10) over ( partition by Year  order by PF_min) as quartile_PF,
  ntile(10) over ( partition by Year  order by FT_pct) as quartile_FT_pct, 
  ntile(10) over ( partition by Year  order by _2pt_pct) as quartile_2pt_pct,
  ntile(10) over ( partition by Year  order by _3pt_pct) as quartile_3pt_pct,
  ntile(10) over ( partition by Year  order by eFG_pct) as quartile_eFG_pct,
  ntile(10) over ( partition by Year  order by BPM) as BPM,


FROM `nbachampionsproject.stats.Final_june_10th`
)

SELECT
 Team,
 Year,
 countif(quartile_pt >= 6) as points,
 countif(quartile_PER >= 6) as PER,
 countif(quartile_Ast >= 6) as Ast,
 countif(quartile_ORB >= 6) as ORB,
 countif(quartile_DRB >= 6) as DRB,
  countif(quartile_BLK >= 6) as BLK,
 countif(quartile_STL>= 6) as STL,
 countif(quartile_TOV >= 6) as TOV,
 countif(quartile_Ast_TOV >= 6) AST_TOV,
 countif(quartile_PF >= 6) as PF,
 countif(quartile_FT_pct >= 6) as FT_pct,
 countif(quartile_2pt_pct >= 6) as _2pt_pct,
 countif(quartile_3pt_pct >= 6) as _3pt_pct,
 countif(quartile_eFG_pct >= 6) as eFG,
  countif(BPM >= 6) as BPM


FROM quartis
Group By
  Team, Year
order by
  year,Team
