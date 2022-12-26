-- Створити тригер, який при додаванні нового чеку (sale) заповнює поле date поточним часом.

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