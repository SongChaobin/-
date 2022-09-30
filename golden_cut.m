%黄金分割法
%输入参数: 迭代区间[a,b],最终迭代区间的精度epsilon,迭代函数对象func
%输出参数:
%单个返回值返回极小值处的x值
%两个返回值第一个返回极小值处的x值,第二个返回迭代次数
%三个返回值第一个返回极小值处的x值,第二个返回迭代次数,第三个返回极小值
function [x,varargout] = golden_cut(a,b,epsilon,func)

%定义count常量,记录迭代次数
persistent count;
if isempty(count)
    count = 0;
end

%step1
if abs(b-a) < epsilon        %判断a,b间隔是否足够小,若足够小则直接返回
    x = (a+b)/2;
else                         %否则进行迭代
%step2
    count = count + 1;
    %求x1,x2
    x_2 = a + (sqrt(5)-1)/2 .* (b - a);      
    x_1 = a + (1-(sqrt(5)-1)/2) .* (b - a);
%step3
    %求函数值f(x1),f(x2)
    f_2 = func(x_2);        
    f_1 = func(x_1);
%step4
    %迭代
    if f_1 == f_2            
        a = x_1;
        b = x_2;
        x = golden_cut(a,b,epsilon,func);
    elseif f_1 > f_2
        a = x_1;
        x = golden_cut(a,b,epsilon,func);
    else 
        b = x_2;
        x = golden_cut(a,b,epsilon,func);
    end
end

if nargout == 2
    %返回迭代次数
    varargout{1} = count;
end
if nargout == 3
    varargout{1} = count;
    %返回极小值
    varargout{2} = func(x);
end