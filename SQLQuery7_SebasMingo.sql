SELECT TOP 200
	Users.DisplayName,
	(SELECT COUNT (*) FROM Posts WHERE OwnerUserId = Users.Id) As TotalPosts,
	(SELECT COUNT (*) FROM Comments WHERE UserId = Users.Id) As TotalComments,
	(SELECT COUNT (*) FROM Badges WHERE UserId = Users.Id) As TotalBadges
FROM
	Users
ORDER BY
	TotalPosts DESC, Users.DisplayNAme;