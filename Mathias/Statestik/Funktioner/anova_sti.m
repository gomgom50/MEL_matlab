function  anova_sti( aMdl )
% This function summarises an Analysis of Variance (ANOVA) for a linear
% regression model (aMdl, given as input) which has been previously
% generated as output from the MatLab model fitlm


    %% Values from the model created by fitlm
    SSreg = aMdl.SSR;
    SSres = aMdl.SSE;
    SStotal = aMdl.SST;
    n = aMdl.NumObservations;
    k = aMdl.NumCoefficients - 1;
    
    %% Degrees of freedom
    DFreg = k;
    DFres = n-k-1;
    DFtotal = n-1;

    %% Mean Squares
    MSreg = SSreg/DFreg;
    MSres = SSres/DFres;
    MStotal = SStotal/DFtotal;
    
    %% F and pValue
    Fval = MSreg/MSres;
    pVal = 1 - fcdf(Fval, DFreg, DFres);

    %% Creating the ANOVA table
    % All columns must have same data type. In order to have empty table
    % cells we transform floats into strings using sprintf
    emptystr = '          ';    % Used for the empty table cells
    format = '%10.5g';          % Input format for sprintf

    % The columns
    SumSq = [SSreg; SSres; SStotal];
    DF = [DFreg; DFres; DFtotal];
    MeanSq = [sprintf(format,MSreg); sprintf(format,MSres); emptystr];
    F = [sprintf(format, Fval); emptystr; emptystr];
    pValue = [sprintf(format, pVal); emptystr; emptystr];
    
    % Row names
    Rws = {'Regression';'Residual';'Total'};
    
    % Assemple all in a table and display it
    anova = table(SumSq, DF, MeanSq, F, pValue, 'RowNames',Rws);
    disp(' ');
    disp('ANOVA_STI:');
    disp(anova);
    
    R2 = 1 - SSres/SStotal;
    R2adj = 1 - (SSres/DFres)/(SStotal/DFtotal);
    s = strcat('    R-squared: ', sprintf(format, R2), ', Adjusted R-squared: ', sprintf(format, R2adj) );
    disp (s);
end

