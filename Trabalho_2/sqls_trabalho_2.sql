	-- select in 
	-- seleciona os lotes de entrada dos peruarios nº 1 e 5
	SELECT * 
	FROM entrada_aves AS a 
	WHERE a.peruario_id IN (1,5); 


	-- select exists 
	-- selecionar os peruarios que houveram mortes 

	SELECT DISTINCT * 
	FROM peruario_mortalidade AS a 
	WHERE EXISTS (
		SELECT * 
		FROM peruario AS b
		WHERE b.id = a.peruario_id
	);


	-- select natural join 
	-- seleciona o medicamento e a respectiva quantidade de cada 
	SELECT DISTINCT a.nome, b.quantidade 
	FROM medicamento AS a 
	NATURAL JOIN medicamento_estq AS b;

	--select inner join 
	-- seleciona os medicamentos que ainda possuem estoque maior igual a 1
	SELECT DISTINCT a.* 
	FROM medicamento AS a 
	INNER JOIN medicamento_estq AS b 
	ON b.medicamento_id = a.id
	WHERE b.quantidade >= 1;


	-- select outer join 
	-- seleciona todos peruários, mesmo que não hajam mortalidades indicadas para o mesmo

	SELECT DISTINCT * 
	FROM peruario_mortalidade AS a 
	RIGHT JOIN peruario AS b 
	ON a.peruario_id = b.id;


	-- select union all 
	-- seleciona todos produtos, o nome e a quantidade (medicamentos e insumos hidricos) 

	SELECT DISTINCT a.nome_medicamento AS produto, 
			 b.quantidade AS quantidade
	FROM insumo_hidrico AS a
	INNER JOIN insumo_hidrico_estq AS b 
	ON a.laboratorio_id = b.insumo_hidrico_id
	UNION ALL 
	SELECT DISTINCT c.nome, 
			 d.quantidade 
	FROM medicamento AS c 
	INNER JOIN medicamento_estq AS d
	ON c.id = d.medicamento_id;

	-- select intersect 
	-- seleciona todos medicamentos os quais existem unidades disponíveis para consumo

	SELECT a.medicamento_id as numero_medicamento
	FROM medicamento_estq as a
	WHERE a.quantidade > 0
	INTERSECT
	SELECT b.id
	FROM medicamento as b;


	-- select group by com having 
	-- selecina todos os peruários que tiveram mortalidade acima de 50 
	SELECT a.peruario_id
	FROM peruario_mortalidade as a 
	GROUP BY a.peruario_id, a.quantidade
	HAVING a.quantidade > 50;


	-- select order by 
	-- seleciona todos as mortalidades em ordem decrescente

	SELECT DISTINCT a.peruario_id, 
		   a.dt_atualizacao
	FROM peruario_mortalidade as a 
	ORDER BY a.dt_atualizacao DESC;



	-- view 
	-- seleciona os 5 peruarios que obtiveram maior índice de mortalidade 

	CREATE VIEW ranking_mortalidade 
	AS 
	SELECT DISTINCT a.peruario_id, 
		   a.quantidade
	FROM peruario_mortalidade as a 
	ORDER BY a.quantidade DESC
	LIMIT 5;

	-- select view 
	SELECT * FROM ranking_mortalidade



