-- Написати функцію price_limit, яка виводить опис алкоголю (item_desc), ціна (retail) якого менша заданого параметру функції bottle_price (integer)


DROP FUNCTION IF EXISTS price_limit(integer); 
CREATE OR REPLACE FUNCTION price_limit(bottle_price integer) 
    RETURNS TABLE (description varchar(50), price decimal(10, 2))
    LANGUAGE 'plpgsql'
AS $$
BEGIN
    RETURN QUERY
        SELECT item_desc, retail
		FROM sale_new
		JOIN details_new USING (invoice)
		JOIN description_new USING(item_num)
		WHERE details_new.retail < bottle_price;
END;
$$;

SELECT * FROM price_limit(10);
