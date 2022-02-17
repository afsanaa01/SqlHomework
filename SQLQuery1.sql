create database FacebookModel

use FacebookModel

create table Users(
	Id int identity primary key,
	Name nvarchar(100),
	Surname nvarchar(100),
	ProfilePhoto nvarchar(200),
	Biography nvarchar(200),
	PostCount int
)

create table Posts(
	Id int identity primary key,
	Image nvarchar(100),
	Text nvarchar(200),
	UserId int references Users(Id)
)

create table Comment(
	Id int identity primary key,
	Text nvarchar(200),
	PostId int references Posts(Id)
)

create view ShowPosts as
Select Users.Name, Users.Surname,Users.ProfilePhoto, Users.Biography,Users.PostCount,Posts.Image,Posts.Text from Posts 
left join Users
on Posts.UserId = Users.Id

SELECT * FROM ShowPosts;


create function CommentCountWithIdd (@UserId int) 
returns int
as
begin
	declare @Count int
	select @Count = Count(*) from Comment where PostId = (select Id from Posts where UserId = @UserId)
	return @Count
end

select dbo.CommentCountWithIdd(3)

