clear;
clc;

target = [1;2;3;6;5;6;1;8;2;2];
length = size(target, 1);
eye_target = [];

for i = 1 : length
    if(target(i, 1) == 1)
        eye_target = [eye_target;1,0,0,0,0,0,0,0,0,0];
    end
    if(target(i, 1) == 2)
        eye_target = [eye_target;0,1,0,0,0,0,0,0,0,0];
    end
    if(target(i, 1) == 3)
        eye_target = [eye_target;0,0,1,0,0,0,0,0,0,0];
    end
    if(target(i, 1) == 4)
        eye_target = [eye_target;0,0,0,1,0,0,0,0,0,0];
    end
    if(target(i, 1) == 5)
        eye_target = [eye_target;0,0,0,0,1,0,0,0,0,0];
    end
    if(target(i, 1) == 6)
        eye_target = [eye_target;0,0,0,0,0,1,0,0,0,0];
    end
    if(target(i, 1) == 7)
        eye_target = [eye_target;0,0,0,0,0,0,1,0,0,0];
    end
    if(target(i, 1) == 8)
        eye_target = [eye_target;0,0,0,0,0,0,0,1,0,0];
    end
    if(target(i, 1) == 9)
        eye_target = [eye_target;0,0,0,0,0,0,0,0,1,0];
    end
    if(target(i, 1) == 0)
        eye_target = [eye_target;0,0,0,0,0,0,0,0,0,1];
    end
end
