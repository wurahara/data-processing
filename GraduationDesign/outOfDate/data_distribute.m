function [ cell_save ] = data_distribute( PINs, line, labeled_mat )
% 初始化25个矩阵，用于存储分类后的数据
mat00 = [];mat01 = [];mat02 = [];mat03 = [];mat04 = [];
mat05 = [];mat06 = [];mat07 = [];mat08 = [];mat09 = [];
mat10 = [];mat11 = [];mat12 = [];mat13 = [];mat14 = [];
mat15 = [];mat16 = [];mat17 = [];mat18 = [];mat19 = [];
mat20 = [];mat21 = [];mat22 = [];mat23 = [];mat24 = [];
mat_other = [];

% 按PIN码（字符型）对数据进行分类
for i = 1 : line
    switch(PINs(i,:))
        case '6365'
            mat00 = [mat00; labeled_mat(i,:)];
        case '0121'
            mat01 = [mat01; labeled_mat(i,:)];
        case '7776'
            mat02 = [mat02; labeled_mat(i,:)];
        case '2746'
            mat03 = [mat03; labeled_mat(i,:)];
        case '0345'
            mat04 = [mat04; labeled_mat(i,:)];
            
            
        case '2477'
            mat05 = [mat05; labeled_mat(i,:)];
        case '0759'
            mat06 = [mat06; labeled_mat(i,:)];
        case '2534'
            mat07 = [mat07; labeled_mat(i,:)];
        case '2066'
            mat08 = [mat08; labeled_mat(i,:)];
        case '8832'
            mat09 = [mat09; labeled_mat(i,:)];
        
        
        case '2520'
            mat10 = [mat10; labeled_mat(i,:)];
        case '3441'
            mat11 = [mat11; labeled_mat(i,:)];
        case '2189'
            mat12 = [mat12; labeled_mat(i,:)];
        case '1084'
            mat13 = [mat13; labeled_mat(i,:)];
        case '3755'
            mat14 = [mat14; labeled_mat(i,:)];
        
        
        case '0331'
            mat15 = [mat15; labeled_mat(i,:)];
        case '9769'
            mat16 = [mat16; labeled_mat(i,:)];
        case '5539'
            mat17 = [mat17; labeled_mat(i,:)];
        case '6400'
            mat18 = [mat18; labeled_mat(i,:)];
        case '8969'
            mat19 = [mat19; labeled_mat(i,:)];
        
        
        case '5182'
            mat20 = [mat20; labeled_mat(i,:)];
        case '4943'
            mat21 = [mat21; labeled_mat(i,:)];
        case '9816'
            mat22 = [mat22; labeled_mat(i,:)];
        case '0788'
            mat23 = [mat23; labeled_mat(i,:)];
        case '9181'
            mat24 = [mat24; labeled_mat(i,:)];
        otherwise
            mat_other = [mat_other; labeled_mat(i,:)];
    end
end
cell_save = cell(25, 1);
cell_save{1,1}=mat00;cell_save{2,1}=mat01;cell_save{3,1}=mat02;cell_save{4,1}=mat03;cell_save{5,1}=mat04;
cell_save{6,1}=mat05;cell_save{7,1}=mat06;cell_save{8,1}=mat07;cell_save{9,1}=mat08;cell_save{10,1}=mat09;
cell_save{11,1}=mat10;cell_save{12,1}=mat11;cell_save{13,1}=mat12;cell_save{14,1}=mat13;cell_save{15,1}=mat14;
cell_save{16,1}=mat15;cell_save{17,1}=mat16;cell_save{18,1}=mat17;cell_save{19,1}=mat18;cell_save{20,1}=mat19;
cell_save{21,1}=mat20;cell_save{22,1}=mat21;cell_save{23,1}=mat22;cell_save{24,1}=mat23;cell_save{25,1}=mat24;

end

