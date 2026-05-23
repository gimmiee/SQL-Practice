/*
Working platform: MySQL

Purpose:
For each contest date:
- Count the number of hackers who made submissions every day
  starting from the first day of the contest
- Identify the hacker who made the maximum number of submissions that day
- If multiple hackers have the same submission count,
  select the lowest hacker_id

Approach:
1. Compute each hacker's cumulative active days
2. Compare cumulative participation with contest day number
   to identify continuous participants
3. Count valid hackers per day
4. Compute daily submission counts per hacker
5. Rank hackers per day by:
   - submission count DESC
   - hacker_id ASC
6. Join both results together
*/

WITH daily_submissions AS (
    SELECT
        submission_date,
        hacker_id,
        COUNT(*) AS submission_count
    FROM submissions
    GROUP BY submission_date, hacker_id
),

continuous_participants AS (
    SELECT
        submission_date,
        hacker_id
    FROM (
        SELECT
            submission_date,
            hacker_id,
            COUNT(DISTINCT submission_date) OVER (
                PARTITION BY hacker_id
                ORDER BY submission_date
            ) AS participated_days,
            
            DATEDIFF(
                submission_date,
                '2016-03-01'
            ) + 1 AS contest_day
        FROM submissions
    ) t
    WHERE participated_days = contest_day
),

daily_unique_hackers AS (
    SELECT
        submission_date,
        COUNT(DISTINCT hacker_id) AS unique_hackers
    FROM continuous_participants
    GROUP BY submission_date
),

daily_ranked AS (
    SELECT
        ds.submission_date,
        ds.hacker_id,
        h.name,
        ds.submission_count,
        ROW_NUMBER() OVER (
            PARTITION BY ds.submission_date
            ORDER BY ds.submission_count DESC,
                     ds.hacker_id ASC
        ) AS rn
    FROM daily_submissions ds
    JOIN hackers h
        ON ds.hacker_id = h.hacker_id
)

SELECT
    dr.submission_date,
    duh.unique_hackers,
    dr.hacker_id,
    dr.name
FROM daily_ranked dr
JOIN daily_unique_hackers duh
    ON dr.submission_date = duh.submission_date
WHERE dr.rn = 1
ORDER BY dr.submission_date;


/*
Working platform: MySQL

Purpose:
매일 아래 정보를 출력한다.
1. 대회 첫날(2016-03-01)부터 하루도 빠지지 않고 제출한 해커 수
2. 해당 날짜에 가장 많이 제출한 해커 정보
   (동점이면 hacker_id가 더 작은 사람 선택)

핵심 아이디어:
- "연속 참여 여부" 계산
- "일별 제출왕" 계산
- 마지막에 두 결과를 날짜 기준으로 합치기

WITH daily_submissions AS (

    /*
    [Step 1]
    날짜별 + 해커별 제출 횟수 계산

    예시 결과:
    +----------------+-----------+------------------+
    | submission_date| hacker_id | submission_count |
    +----------------+-----------+------------------+
    | 2016-03-01     | 101       | 5                |
    | 2016-03-01     | 102       | 3                |
    +----------------+-----------+------------------+
    */

    SELECT
        submission_date,
        hacker_id,
        COUNT(*) AS submission_count
    FROM submissions
    GROUP BY submission_date, hacker_id
),

continuous_participants AS (

    /*
    [Step 2]
    첫날부터 하루도 빠지지 않고 제출한 사람 찾기

    핵심 개념:
    "참여한 날짜 수" =
    "대회 시작일부터 현재 날짜까지 지난 일수"

    이 두 개가 같으면 하루도 안 빠진 것
    */

    SELECT
        submission_date,
        hacker_id
    FROM (

        SELECT
            submission_date,
            hacker_id,

            /*
            해커별 누적 참여 날짜 수 계산

            예:
            hacker 101
            03-01 -> 1
            03-02 -> 2
            03-03 -> 3
            */

            COUNT(DISTINCT submission_date) OVER (
                PARTITION BY hacker_id
                ORDER BY submission_date
            ) AS participated_days,

            /*
            대회 시작일부터 몇 번째 날인지 계산

            예:
            03-01 -> 1
            03-02 -> 2
            03-03 -> 3
            */

            DATEDIFF(
                submission_date,
                '2016-03-01'
            ) + 1 AS contest_day

        FROM submissions
    ) t

    /*
    participated_days = contest_day

    => 첫날부터 하루도 빠지지 않고 참여한 사람
    */

    WHERE participated_days = contest_day
),

daily_unique_hackers AS (

    /*
    [Step 3]
    날짜별 연속 참여자 수 계산

    예:
    +----------------+----------------+
    | submission_date| unique_hackers |
    +----------------+----------------+
    | 2016-03-01     | 4              |
    | 2016-03-02     | 3              |
    +----------------+----------------+
    */

    SELECT
        submission_date,
        COUNT(DISTINCT hacker_id) AS unique_hackers
    FROM continuous_participants
    GROUP BY submission_date
),

daily_ranked AS (

    /*
    [Step 4]
    날짜별 제출 순위 계산

    정렬 기준:
    1. 제출 수 DESC
    2. hacker_id ASC

    ROW_NUMBER() = 1
    => 해당 날짜 제출왕
    */

    SELECT
        ds.submission_date,
        ds.hacker_id,
        h.name,
        ds.submission_count,

        ROW_NUMBER() OVER (
            PARTITION BY ds.submission_date
            ORDER BY ds.submission_count DESC,
                     ds.hacker_id ASC
        ) AS rn

    FROM daily_submissions ds

    JOIN hackers h
        ON ds.hacker_id = h.hacker_id
)

-- [Step 5]
-- 연속 참여자 수 + 제출왕 결과 합치기

SELECT
    dr.submission_date,
    duh.unique_hackers,
    dr.hacker_id,
    dr.name

FROM daily_ranked dr

JOIN daily_unique_hackers duh
    ON dr.submission_date = duh.submission_date

-- rn = 1 => 날짜별 제출 1등
WHERE dr.rn = 1

ORDER BY dr.submission_date;
*/
