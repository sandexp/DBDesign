# ���˼�����Ҫ����ִ�������У��֮�� ���������õ�Ԫ���Խ���У��

-- ��ʾ��ǰ���ݿ��µ����ݱ�
show tables;


-- �������ݱ� student
create table student(
	s_id	int,
	first_name	char,
	second_name char,
	age	int
);

create table course(
	c_id	int,
	course_name	char,
);

create table score(
	s_id	int,
	c_id	int,
	score	float
);

create table register(
	s_id	int,
	register_date date,
	unregister_date	date default null
);

# �������ݲ������� #
-- �Ϸ�����
insert into student(s_id,first_name,second_name,age) values (1,'lollipop','hh',23);
insert into student(s_id,first_name,second_name,age) values (2,'sandee','dg',27);

-- ���Ͳ�ƥ��
insert into student(s_id,first_name,second_name,age) values ('1','lollipop','hh',23);

-- �ֶ�ȱʧ
insert into student(s_id,first_name) values (1,'lollipop');

-- �ֶγ��Ȳ�ƥ��
insert into student(s_id,first_name,second_name,age) values (1,'lollipop','hh');

# �������������� #
-- ��ν������
update student set first_name='loli' where s_id=1

-- ��ν������
update student set first_name='wsd' where s_id=2 and age=27

# ����ʾ��
-- ������
update person set first_name='loli' where s_id=1

-- �����ֶβ�����
update student set first_name='loli' where p_id=1

update student set last_name='loli' where s_id=1

-- ���Ͳ�ƥ��
update student set first_name=777 where s_id=1


# ɾ����¼

delete from student where s_id=1;

-- ɾ������Ϣ������ 
delete from person where s_id=1

-- ɾ�����������Բ�����
delete from student where p_id=1


-- У��ɾ��֮�������Ͳ�ѯ�Ƿ������� - ִ��֮�����ִ��, ��Ԫ���Բ���Ҫ
select * from student;
delete from student where s_id=1;
select * from student;
insert into student(s_id,first_name,second_name,age) values (1,'lollipop','hh',23);
select * from student;

# drop���ݱ�
drop table student;

-- ɾ���ı�����
drop table person;

-- ɾ����У�� - ��Ԫ���Բ���Ҫ
drop table student;
show tables;
select * from student; -- ��Ҫ����У�����

# descУ�� 
desc student;

# ��������У��
create index idx on student(first_name);
-- �����Ʋ�����
create index idx on person(first_name);
-- �����ֶδ���
create index idx on student(last_name);

-- ͬһ����ָ��ͬ������ �������
create index idx on student(first_name);
create index idx on student(second_name);

# ����Ψһ����
create unique index idqx on student(second_name);
# TODO

# ɾ������ ��Ҫ�ȴ�������������У��ʧ��
drop index idx;
drop index idx2;


# ��������ָ��У�� ��Ҫ��У���ļ��Լ���Ԫ���ݵ���ȷ��
load data 'f1.txt' into table student;

### select ���

# ��select ���
select * from student where s_id=1;

-- ��Ԫ���ݴ���
select * from person where s_id=1;

-- ���Դ���
select * from student where p_id=1;

-- ����A��,A���*��A����ͨ�ֶβ���
select * ,first_name from student where s_id=1;

# ȫ�֣� ͶӰ������Ϊ�ۺ��ֶ� ��ҪУ��ۺ��ֶ����Ƿ�Ϊ���������Ա��ʽ ���������У��ʧ��,��ͶӰ�в�Ӧ����������������ͨ�ֶ�
select count(1) from student;
select max(age) from student;
select min(age) from student;
select avg(age) from student;

# �ֲ�������group by�ľۺϱ��ʽ�� �ֶ��в�Ӧ�ð������˷����ֶκ;ۺ��ֶε�������ͨ�ֶ�
select count(1) from student group by first_name;
select max(age) from student group by first_name;
select min(age) from student group by first_name;
select avg(age) from student group by first_name;

# order�ֶε�У�� ��ָ����Ϊasc
select * from student order by age asc;
select * from student order by age desc;
select * from student order by age desc,s_id asc;

-- ������ �Լ����������ֶβ�����
select * from student order by score asc;
select * from person order by age asc;

# ν�ʲ����������ʽУ��
select * from student as s1,student as s2 where s1.age+s2.age>50 and s1.age>s2.age;

-- У��� ���ԵĴ�����
select * from person as s1,student as s2 where s1.age+s2.age>50 and s1.age>s2.age;

-- У��� ���������Ƿ�֧�ַ�������
select * from student as s1,student as s2 where s1.first_name+s2.age>50 and s1.age>s2.age;

## ���Ӳ�ѯ
# ��Ȼ����
select s1.s_id,s2.* from student as s1,student as s2;
select s1.*,s2.* from student as s1,student as s2;
select student.s_id,course.c_id from student,course

-- ��У��ʧ��
select s1.s_id,s2.* from person as s1,student as s2;

-- ����У��ʧ��
select s1.p_id,s2.* from student as s1,student as s2;
select s1.s_id,s2.*,s2.s_id from student as s1,student as s2;
select s1.s_id,s3.* from student as s1,student as s2;

# ������
select
	s.first_name,
	s.second_name,
	c.course_name,
	g.score
from
	student as s
inner join
	score as g
on
	s.s_id=g.s_id
inner join
	course as c
on
	g.c_id=c.c_id
;

-- ������
select
	s.first_name,
	s.second_name,
	c.course_name,
	g.score
from
	person as s
inner join
	score as g
on
	s.s_id=g.s_id
inner join
	course as c
on
	g.c_id=c.c_id
;

-- �����Դ���
select
	s.first_name,
	s.last_name,
	c.course_name,
	g.score
from
	student as s
inner join
	score as g
on
	s.s_id=g.s_id
inner join
	course as c
on
	g.c_id=c.c_id
;

-- ����û���ֹ��ı���
select
	s1.first_name,
	s.last_name,
	c.course_name,
	g.score
from
	student as s
inner join
	score as g
on
	s.s_id=g.s_id
inner join
	course as c
on
	g.c_id=c.c_id
;

-- on���ʽ�������Ͳ�һ��
select
	s.first_name,
	s.second_name,
	c.course_name,
	g.score
from
	student as s
inner join
	score as g
on
	s.first_name=g.s_id
inner join
	course as c
on
	g.c_id=c.c_id
;

# ������ ����

# ȫ���� ����
