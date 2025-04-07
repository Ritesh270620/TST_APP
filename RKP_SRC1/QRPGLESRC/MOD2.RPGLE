     **free

          dcl-proc export2 export;
              dcl-pr export3;
                 var3 char(10);
              end-pr;
              dcl-pr export2;
                 var2 char(10);
              end-pr;
              dcl-pi export2;
                 var2 char(10);
              end-pi;
              callp export3(var2);
              *inlr = *on;
          end-proc;
