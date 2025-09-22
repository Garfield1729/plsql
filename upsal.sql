delimiter //

create procedure upsal()
begin
		declare vempno, v_set int default 0;
		declare vsal,vnewsal double(12,2);
		declare vename, vjob varchar(25);
		declare vhiredate date;
		declare empcur cursor for select empno, ename, job,sal,hiredate from emp;
		declare continue handler for not found set v_set=1;
		
		open empcur;
		
		label1 : loop 
			fetch empcur into vempno, vename, vjob, vsal, vhiredate;
			if v_set=1 then 
				leave label1;
			end if;
			if timestampdiff(year, vhiredate,curdate())>=35 and timestampdiff(year, vhiredate,curdate())<=38 then 
				set vnewsal=vsal*1.20;
			elseif timestampdiff(year, vhiredate,curdate())>38 then
				set vnewsal=vsal*1.25;
			else 
				set vnewsal=vsal;
			end if;
			update emp set sal=vnewsal
			where empno=vempno;
		end loop;
		close empcur;
end //

delimiter ;

call upsal();
