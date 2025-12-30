rng(12345);
true_class        = [1, 2, 3, 1, 4, 5, 6, 2];
unlucky_class     = [2, 2, 1, 1, 3, 3, 3, 3];
replicates = 10000;
random_classes    = randi(6 , replicates, 8);
AR1 = 0;
for i = 1:replicates
    AR1=AR1+RandIndexFS(random_classes(i,:),true_class);
end
AR1 = AR1/replicates;
AR2 = RandIndexFS(unlucky_class,true_class);
disp(['Mean ARI = ' num2str(AR1) ' --- Unlucky ARI = ' num2str(AR2)]);