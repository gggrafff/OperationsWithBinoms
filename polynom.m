classdef polynom
    %����� ��� ������ � ������������
    %����� ��������� �������� � ������������. ����������� �������� ��������,
    %���������, ���������, �������.
    properties (Access = private) % ���� �������� ����������� �����, �� ��������� ��� ������
        coefs %������������ ����������
    end
    methods  (Access = public)     % ������������� ������
        function this = polynom(coefficients)
            % �����������. ��������� ������ �������������
            if nargin == 0 %���������, �������� �� ���������
                this.coefs = [ ]; %���� �� ��������
            elseif isa(coefficients, 'polynom') %���������, ������� ������ ��� ������ ��������
                this = coefficients; %���� ������
            else
                this.coefs = coefficients(:).'; %���� ������
            end
        end
        function result = getCoefficients(p)
            %�������� ������������
            result = p.coefs;
        end
        function result = getPow(p)
            %�������� ������� ����������
            result = length(p.coefs);
        end
        function result = isBinom(p)
            %�������� ������� ����������
            logic = p.coefs~=0;
            fl=find(logic == 1);
            if length(fl)==2
                result = true;
            else
                result = false;
            end
        end
        function result = plus(p1,p2)
            %�������� ���������
            if length(p1.getCoefficients())<length(p2.getCoefficients())
                p1.coefs=[zeros(1,length(p2.getCoefficients())-length(p1.getCoefficients())) p1.coefs];
            end
            if length(p1.getCoefficients())>length(p2.getCoefficients())
                p2.coefs=[zeros(1,length(p1.getCoefficients())-length(p2.getCoefficients())) p2.coefs];
            end
            result = polynom(p1.coefs + p2.coefs);
        end
        function result = minus(p1,p2)
            %��������� ���������
            if length(p1.getCoefficients())<length(p2.getCoefficients())
                p1.coefs=[zeros(1,length(p2.getCoefficients())-length(p1.getCoefficients())) p1.coefs];
            end
            if length(p1.getCoefficients())>length(p2.getCoefficients())
                p2.coefs=[zeros(1,length(p1.getCoefficients())-length(p2.getCoefficients())) p2.coefs];
            end
            result = polynom(p1.coefs - p2.coefs);
        end
        function result = mtimes(p1,p2)
            %��������� ���������
            result = polynom(conv(p1.coefs, p2.coefs));
        end
        function result = times(p1,p2)
            %������������ ��������� ���������
            if length(p1.getCoefficients())<length(p2.getCoefficients())
                p1.coefs=[zeros(1,length(p2.getCoefficients())-length(p1.getCoefficients())) p1.coefs];
            end
            if length(p1.getCoefficients())>length(p2.getCoefficients())
                p2.coefs=[zeros(1,length(p1.getCoefficients())-length(p2.getCoefficients())) p2.coefs];
            end
            result = polynom(p1.coefs .* p2.coefs);
        end
        function result = mpower(p, pow)
            %���������� � ������� ���������
            res = p.coefs;
            for i=2:pow
                res=conv(res, p.coefs);
            end
            result = polynom(res);
        end
        function result = power(p, pow)
            %������������ ���������� � ������� ���������
            result = polynom(p.coefs .^ pow);
        end
        function result = mrdivide(p1,p2)
            %������� ���������. ������� �����������
            [q, r] = deconv(p1.coefs, p2.coefs);
            result = polynom(q);
        end
        function result = rdivide(p1,p2)
            %������������ ������� ���������
            if length(p1.getCoefficients())<length(p2.getCoefficients())
                p1.coefs=[zeros(1,length(p2.getCoefficients())-length(p1.getCoefficients())) p1.coefs];
            end
            if length(p1.getCoefficients())>length(p2.getCoefficients())
                p2.coefs=[zeros(1,length(p1.getCoefficients())-length(p2.getCoefficients())) p2.coefs];
            end
            result = polynom(p1.coefs ./ p2.coefs);
        end
        function display(p)
            %�����������
            disp(p.toString);
        end
        function s = toString(p)
            % ��������� ��������� ������������� ��� ��������
            c = p.coefs;
            if all(c == 0)
                s = '0';
            else
                d = length(c)-1;
                s = [ ];
                for a = c;
                    if a ~= 0;
                        if ~isempty(s)
                            if a > 0
                                s = [s ' + '];
                            else
                                s = [s ' - '];
                                a = -a;
                            end
                        end
                        if a ~= 1 | d == 0
                            s = [s num2str(a)];
                            if d > 0
                                s = [s '*'];
                            end
                        end
                        if d >= 2
                            s = [s 'x^' int2str(d)];
                        elseif d == 1
                            s = [s 'x'];
                        end
                    end
                    d = d - 1;
                end
            end
        end
    end
end