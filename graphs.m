%=============================================================
%   Author: Rafael Veras <rafaelmanoelveras@gmail.com>
%   Created at 06/23/2024
%=============================================================

%% Figures
figure;plot(([1:90]*5) , [(1-pchoice) ]);
set(gca, 'ylim', [0 0.16]);
set(gca, 'ytick', 0:0.01:0.16);
xlabel({'(Thousands)','Mileage since last replacement	'});
title(['Estimated Hazard Functions' newline 'beta=' num2str(beta)],'FontSize',14);
legend({['beta=' num2str(beta) ]},'FontSize',12);



figure;plot(([1:90]*5), [ -fixed_point ])
set(gca, 'ylim', [0 8]);
set(gca, 'ytick', 0:1:8);
title(['Estimated Value Functions' newline 'beta=' num2str(beta)],'FontSize',14);
legend({['beta=' num2str(beta) ]},'FontSize',12);

