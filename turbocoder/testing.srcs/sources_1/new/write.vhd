LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_textio.ALL;
USE std.textio.ALL;

ENTITY WriteFile IS
    GENERIC (
        file_name : string := "C:/NIR/fpga_res.dat" 
    );
    PORT (
        clk    : IN  std_logic;  -- �������� ������
        dv     : IN  std_logic;  -- ������ ���������� ������
        DataIn : IN  std_logic   -- ���������� ������� ������ ������
    );
END ENTITY WriteFile;

ARCHITECTURE Behavioral OF WriteFile IS
    FILE file_wr : TEXT OPEN WRITE_MODE IS file_name; 
    SIGNAL index : INTEGER RANGE 0 TO 3*2048-1 := 0;    -- ������� ���������� ����� (3*2048 - 1)
BEGIN
    write_process : PROCESS(clk)
        VARIABLE l : line; 
    BEGIN
        IF rising_edge(clk) THEN
            IF dv = '1' THEN
                -- ���������, ��� ������ ��� �� ��������� (�� 3*2048 ���)
                IF index < 3*2048 THEN
                    IF DataIn = '0' THEN
                        write(l, string'("0"));
                    ELSE
                        write(l, string'("1"));
                    END IF;
                    writeline(file_wr, l);
                    index <= index + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE Behavioral;
