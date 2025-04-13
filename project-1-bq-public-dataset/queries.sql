-- 1. Top 10 most popular tags
SELECT tag_name, COUNT(*) AS tag_count
FROM (
  SELECT SPLIT(tags, '|') AS tag_array
  FROM `bigquery-public-data.stackoverflow.posts_questions`
), UNNEST(tag_array) AS tag_name
GROUP BY tag_name
ORDER BY tag_count DESC
LIMIT 10;


-- 2. Average answer count per tag
SELECT tag_name, ROUND(AVG(answer_count), 2) AS avg_answers
FROM (
  SELECT answer_count, SPLIT(tags, '|') AS tag_array
  FROM `bigquery-public-data.stackoverflow.posts_questions`
), UNNEST(tag_array) AS tag_name
GROUP BY tag_name
ORDER BY avg_answers DESC
LIMIT 10;

-- 3. Year-wise trend of questions posted
SELECT EXTRACT(YEAR FROM creation_date) AS year, COUNT(*) AS total_questions
FROM `bigquery-public-data.stackoverflow.posts_questions`
GROUP BY year
ORDER BY year;

-- 4. Top 10 users with most questions asked
SELECT owner_user_id, COUNT(*) AS total_questions
FROM `bigquery-public-data.stackoverflow.posts_questions`
WHERE owner_user_id IS NOT NULL
GROUP BY owner_user_id
ORDER BY total_questions DESC
LIMIT 10;

-- 5. Questions with the highest score
SELECT id, title, score
FROM `bigquery-public-data.stackoverflow.posts_questions`
ORDER BY score DESC
LIMIT 10;


-- 6. Tags with most unanswered questions
SELECT tag_name, COUNT(*) AS unanswered_count
FROM (
  SELECT tags, answer_count
  FROM `bigquery-public-data.stackoverflow.posts_questions`
  WHERE answer_count = 0 AND tags IS NOT NULL
), UNNEST(SPLIT(tags, '|')) AS tag_name
GROUP BY tag_name
ORDER BY unanswered_count DESC
LIMIT 10;

-- 7. Distribution of questions by score ranges
SELECT
  CASE
    WHEN score < 0 THEN 'Negative'
    WHEN score = 0 THEN 'Zero'
    WHEN score BETWEEN 1 AND 5 THEN '1-5'
    WHEN score BETWEEN 6 AND 20 THEN '6-20'
    WHEN score > 20 THEN '>20'
  END AS score_range,
  COUNT(*) AS question_count
FROM `bigquery-public-data.stackoverflow.posts_questions`
GROUP BY score_range
ORDER BY question_count DESC;


-- 8. Average title length over years
SELECT EXTRACT(YEAR FROM creation_date) AS year,
       ROUND(AVG(LENGTH(title)), 2) AS avg_title_length
FROM `bigquery-public-data.stackoverflow.posts_questions`
GROUP BY year
ORDER BY year;

-- 9. Month-wise question posting pattern (regardless of year)
SELECT EXTRACT(MONTH FROM creation_date) AS month,
       COUNT(*) AS total_questions
FROM `bigquery-public-data.stackoverflow.posts_questions`
GROUP BY month
ORDER BY month;


-- 10. Tag usage trend over years ('python')
SELECT EXTRACT(YEAR FROM creation_date) AS year, COUNT(*) AS python_questions
FROM `bigquery-public-data.stackoverflow.posts_questions`
WHERE tags LIKE '%python%'
GROUP BY year
ORDER BY year;
