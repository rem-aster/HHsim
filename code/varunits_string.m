function [ret] = varunits_string (n_qty, label)
%input quantity in nano ...

a_qty = abs(n_qty);
if (a_qty>=1e9)
  label_prefix='';
  n_qty=n_qty/1e9;
elseif (a_qty>=1e6)
  label_prefix='м';
  n_qty=n_qty/1e6;
elseif (a_qty>=1e3)
  label_prefix='мк';
  n_qty=n_qty/1e3;
else
  label_prefix='н';
end

val=sprintf('%3.2f',n_qty);
ret=[val ' ' label_prefix label];
