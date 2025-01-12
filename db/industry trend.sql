declare @lgaLabel nvarchar(max)

set @lgaLabel = 'Renmark Paringa (DC)';

with preYear as (
select row_number() over (partition by [year] order by IndustryLabel) as r, * from dbo.IndustryByTurnoverSizeRange where LGALabel = @lgaLabel and [year] = '2017'),
curYear as (
select row_number() over (partition by [year] order by IndustryLabel) as r, * from dbo.IndustryByTurnoverSizeRange where LGALabel = @lgaLabel and [year] = '2018')
select curYear.IndustryLabel, curYear.LGALabel, cast(curYear.[Total] as int) - cast(preYear.[Total] as int) as newBusinessFromPreviousYear, curYear.Total from preYear join curYear on preYear.IndustryCode = curYear.IndustryCode
order by newBusinessFromPreviousYear desc, Total

