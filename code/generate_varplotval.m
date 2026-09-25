function z = generate_varplotval(popupval, valueindex)

global vars

if (popupval < 13)
    z = vars.varplotdata(popupval, valueindex);
else
    z = NaN;
end