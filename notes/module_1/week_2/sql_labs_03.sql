/*
joins various tables to figure out what titles each author has published at which publishers. 
Your output should have at least the following columns:
AUTHOR ID - the ID of the author
LAST NAME - author last name
FIRST NAME - author first name
TITLE - name of the published title
PUBLISHER - name of the publisher where the title was published
*/

SELECT
	au.au_id			AS autor_ID,
    au.au_lname			AS last_name,
    au.au_fname			AS first_name,
    ti.title			AS title,
    pu.pub_name			AS publisher
FROM publication.authors				au
	LEFT JOIN publication.titleauthor	ta
    ON au.au_id = ta.au_id
    LEFT JOIN publication.titles		ti
    ON ta.title_id = ti.title_id
    LEFT JOIN publication.publishers	pu
    ON ti.pub_id = pu.pub_id;
    
/*
Elevating from your solution in Challenge 1, 
query how many titles each author has published at each publisher. 
*/
SELECT
	au.au_id			AS autor_ID,
    au.au_lname			AS last_name,
    au.au_fname			AS first_name,
    pu.pub_name			AS publisher,
    COUNT(ti.title)		AS title_count
FROM publication.authors				au
	LEFT JOIN publication.titleauthor	ta
    ON au.au_id = ta.au_id
    LEFT JOIN publication.titles		ti
    ON ta.title_id = ti.title_id
    LEFT JOIN publication.publishers	pu
    ON ti.pub_id = pu.pub_id
GROUP BY
	au.au_id,
    pu.pub_name;
    
/*
Who are the top 3 authors who have sold the highest number of titles?
our output should have the following columns:
AUTHOR ID - the ID of the author
LAST NAME - author last name
FIRST NAME - author first name
TOTAL - total number of titles sold from this author
Your output should be ordered based on TOTAL from high to low.
Only output the top 3 best selling authors.
*/
SELECT
	au.au_id			AS autor_id,
    au.au_lname			AS last_name,
    au.au_fname			AS first_name,
    SUM(sa.qty)			AS total_sells
FROM publication.authors				au
	INNER JOIN publication.titleauthor	ta
    ON au.au_id = ta.au_id
	INNER JOIN publication.sales		sa
    ON ta.title_id = sa.title_id
GROUP BY au.au_id
ORDER BY total_sells DESC
LIMIT 3;

/*
Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3.
Note that the authors who have sold 0 titles should also appear in your output (ideally display 0 instead of NULL as the TOTAL). 
Also order your results based on TOTAL from high to low.
*/
SELECT
	au.au_id						AS autor_id,
    au.au_lname						AS last_name,
    au.au_fname						AS first_name,
    COALESCE(SUM(sa.qty), 0)		AS total_sells
FROM publication.authors				au
	INNER JOIN publication.titleauthor	ta
    ON au.au_id = ta.au_id
	INNER JOIN publication.sales		sa
    ON ta.title_id = sa.title_id
GROUP BY au.au_id
ORDER BY total_sells DESC;

/*Authors earn money from their book sales in two ways: advance and royalties. 
An advance is the money that the publisher pays the author before the book comes out. 
The royalties the author will receive is typically a percentage of the entire book sales. 
The total profit an author receives by publishing a book is the sum of the advance and the royalties.

Given the information above, who are the 3 most profiting authors and how much royalties each of them have received? 
Your output should have the following columns:
AUTHOR ID - the ID of the author
LAST NAME - author last name
FIRST NAME - author first name
PROFIT - total profit the author has received combining the advance and royalties
Your output should be ordered from higher PROFIT values to lower values.
Only output the top 3 most profiting authors.
*/
SELECT
	au_id						AS 'Author ID',
    au_lname					AS 'Last Name',
    au_fname					AS 'First Name',
    SUM(advance + royalties)	AS profits FROM (
    SELECT
		title_id, 
        au_id, 
        au_lname, 
        au_fname, 
        advance, 
        SUM(Royalties)			AS royalties FROM (
        SELECT
			t.title_id,
            t.price,
            t.advance * (ta.royaltyper / 100) 	AS advance,
            t.royalty,
            s.qty,
            a.au_id,
            au_lname,
            au_fname,
            ta.royaltyper,
            (t.price * s.qty * t.royalty * ta.royaltyper / 10000)	AS royalties
            FROM publication.titles					t
				INNER JOIN publication.sales		s
				ON s.title_id = t.title_id
                INNER JOIN publication.titleauthor 	ta
                ON ta.title_id = s.title_id
                INNER JOIN publication.authors		a
                ON a.au_id = ta.au_id
		)										AS tmp
		GROUP BY
			au_id,
			title_id
)											AS tmp2
GROUP BY
	au_id
ORDER BY profits DESC
LIMIT 3;
