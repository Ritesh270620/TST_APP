     **free

          dcl-proc export3 export;
              dcl-pr export1;
                 var1 char(10);
              end-pr;
              dcl-pr export3;
                 var3 char(10);
              end-pr;
              dcl-pi export3;
                 var3 char(10);
              end-pi;
              callp export1(var3);
              *inlr = *on;
          end-proc;
