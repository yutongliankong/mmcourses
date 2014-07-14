
<cfquery name="qcategories" datasource="acfd700-lab">
  select category.categoryid,categoryname,1 as bChecked
  from category, articlecategory 
  where category.categoryid = articlecategory.categoryid
	and  articlecategory.articleid = #articleid#
	  and category.endtime is null
	
	UNION
	
	select categoryid, categoryname, 0 as bchecked
	from category
	where category.categoryid not in (
		select categoryid
		from articlecategory
		where articleid = #articleid#
	)
	and endtime is null

 	order by categoryname
</cfquery>
