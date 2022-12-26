-- Створити процедуру , яка змінює кількість (quantity) проданих пляшок алкоголю у чеку(sale) на задану

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