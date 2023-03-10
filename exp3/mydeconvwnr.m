function J = mydeconvwnr(I, PSF, NSR)

sizeI = size(I);
H = psf2otf(PSF, sizeI);

S_u = NSR;
S_x = 1;

denom = abs(H).^2;
denom = denom .* S_x;
denom = denom + S_u;
clear S_u

% Make sure that denominator is not 0 anywhere.  Note that denom at this
% point is nonnegative, so we can just add a small term without fearing a
% cancellation with a negative number in denom.
denom = max(denom, sqrt(eps));

G = conj(H) .* S_x;
clear H S_x
G = G ./ denom;
clear denom

% Apply the filter G in the frequency domain.
J = ifftn(G .* fftn(I));
clear G

J = real(J);