-- Перевірка функції price_limit

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

-- Виклик функції
SELECT * FROM price_limit(10);



-- Перевірка процедури update_quantity

DROP PROCEDURE IF EXISTS update_quantity(varchar(50), integer);
CREATE OR REPLACE PROCEDURE update_quantity(upd_invoice varchar(50), new_quantity integer)
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE details_new
	SET invoice = invoice, item_num = item_num, quantity = new_quantity, cost = cost, retail = retail
	WHERE invoice = upd_invoice;
END;
$$;

-- Виклик процедури
SELECT * FROM details_new
CALL update_quantity()



-- Перевірка триггеру sale_trigger

DROP TRIGGER IF EXISTS sale_trigger ON sale_new;

CREATE OR REPLACE FUNCTION upd_date() RETURNS trigger 
LANGUAGE plpgsql
AS
$$
     BEGIN
          UPDATE sale_new
          SET store_name = store_name,
			  vendor_num = vendor_num,
			  sale_date = current_date
		  WHERE sale_new.invoice = NEW.invoice;
		  RETURN NULL;
     END;
$$;

CREATE TRIGGER sale_trigger
AFTER INSERT ON sale_new
FOR EACH ROW EXECUTE FUNCTION upd_date();

SELECT * FROM sale_new

INSERT INTO sale_new(invoice, store_name, vendor_num, sale_date)
VALUES('SK111111111', 'Becher Beverage', 55, '1939-10-30')