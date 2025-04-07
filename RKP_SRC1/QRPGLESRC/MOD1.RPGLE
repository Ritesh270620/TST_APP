     **free

          dcl-proc export1 export;
              dcl-pr export2;
                 var2 char(10);
              end-pr;
              dcl-pr export1;
                 var1 char(10);
              end-pr;
              dcl-pi export1;
                 var1 char(10);
              end-pi;
              callp export2(var1);
              *inlr = *on;
          end-proc;
