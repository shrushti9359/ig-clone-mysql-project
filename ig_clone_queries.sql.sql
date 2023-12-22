use instagram_clone_db;

-- 1.Create an ER diagram or draw a schema for the given database.

-- 2.We want to reward the user who has been around the longest, Find the 5 oldest users.
select * from users  -- Rewarding the user who has been around the longest
where created_at = ( select MIN(created_at ) from users )
order by created_at asc limit 5;

select * from users  -- SHowing 5 oldest users
order by created_at asc limit 5;

-- 3.To target inactive users in an email ad campaign, find the users who have never posted a photo.
select u.id, u.username 
from users u 
where u.id not in (select p.user_id from photos p)
order by u.id;

-- 4.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
select u.id, u.username, l.photo_id, count(*) total_likes
from likes l
inner join photos p on p.id = l.photo_id
inner join users u on u.id = p.user_id 
group by l.photo_id , u.id, u.username
order by total_likes desc
limit 1;

-- 5.The investors want to know how many times does the average user post.
select((select count(*) from photos)/(select count(*) from users)) as avg_post_count;

-- 6.A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
select t.tag_name, count(*) tag_count 
from photo_tags pt
inner join tags t on t.id = pt.tag_id
group by tag_name
order by tag_count desc
limit 5;

-- 7.To find out if there are bots, find users who have liked every single photo on the site.
select u.id,u.username, COUNT(*) as total_likes 
from users u
inner join likes l on u.id = l.user_id
group by u.id,u.username
having total_likes = (select COUNT(*) from photos);

-- 8.Find the users who have created instagramid in may and select top 5 newest joinees from it?
Select id, username from users
where month(created_at) = 5
order by created_at DESC
limit 5;

-- 9.Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?
Select distinct(u.id), (u.username) from users u
inner join photos p on u.id = p.user_id
inner join likes l on p.user_id = l.user_id
where u.username regexp '^c.*[0-9]$';

-- 10.Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
select  u.username,count(*) as Post_count from photos p
inner join users u on p.user_id=u.id 
group by u.username 
having Post_count between 3 and 5 
order by Post_count Desc 
limit 30;


    







