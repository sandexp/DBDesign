# 除了几个需要参与执行任务的校验之外 其他都采用单元测试进行校验

-- 显示当前数据库下的数据表
show tables;


-- 创建数据表 student
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

# 插入数据测试用例 #
-- 合法插入
insert into student(s_id,first_name,second_name,age) values (1,'lollipop','hh',23);
insert into student(s_id,first_name,second_name,age) values (2,'sandee','dg',27);

-- 类型不匹配
insert into student(s_id,first_name,second_name,age) values ('1','lollipop','hh',23);

-- 字段缺失
insert into student(s_id,first_name) values (1,'lollipop');

-- 字段长度不匹配
insert into student(s_id,first_name,second_name,age) values (1,'lollipop','hh');

# 更新语句测试用例 #
-- 单谓词条件
update student set first_name='loli' where s_id=1

-- 多谓词条件
update student set first_name='wsd' where s_id=2 and age=27

# 错误示例
-- 表不存在
update person set first_name='loli' where s_id=1

-- 表中字段不存在
update student set first_name='loli' where p_id=1

update student set last_name='loli' where s_id=1

-- 类型不匹配
update student set first_name=777 where s_id=1


# 删除记录

delete from student where s_id=1;

-- 删除表信息不存在 
delete from person where s_id=1

-- 删除表所属属性不存在
delete from student where p_id=1


-- 校验删除之后新增和查询是否有问题 - 执行之后才能执行, 单元测试不需要
select * from student;
delete from student where s_id=1;
select * from student;
insert into student(s_id,first_name,second_name,age) values (1,'lollipop','hh',23);
select * from student;

# drop数据表
drop table student;

-- 删除的表不存在
drop table person;

-- 删除表校验 - 单元测试不需要
drop table student;
show tables;
select * from student; -- 需要出现校验错误

# desc校验 
desc student;

# 索引创建校验
create index idx on student(first_name);
-- 表名称不存在
create index idx on person(first_name);
-- 索引字段错误
create index idx on student(last_name);

-- 同一索引指向不同的属性 联合语句
create index idx on student(first_name);
create index idx on student(second_name);

# 创建唯一索引
create unique index idqx on student(second_name);
# TODO

# 删除索引 需要先存在有索引否则校验失败
drop index idx;
drop index idx2;


# 载入数据指令校验 主要是校验文件以及表元数据的正确性
load data 'f1.txt' into table student;

### select 语句

# 简单select 语句
select * from student where s_id=1;

-- 表元数据错误
select * from person where s_id=1;

-- 属性错误
select * from student where p_id=1;

-- 对于A表,A表的*与A表普通字段并列
select * ,first_name from student where s_id=1;

# 全局： 投影属性中为聚合字段 需要校验聚合字段中是否为正常的属性表达式 如果不是则校验失败,且投影中不应当包含其他任意普通字段
select count(1) from student;
select max(age) from student;
select min(age) from student;
select avg(age) from student;

# 局部：带有group by的聚合表达式， 字段中不应该包含除了分组字段和聚合字段的其他普通字段
select count(1) from student group by first_name;
select max(age) from student group by first_name;
select min(age) from student group by first_name;
select avg(age) from student group by first_name;

# order字段的校验 不指定则为asc
select * from student order by age asc;
select * from student order by age desc;
select * from student order by age desc,s_id asc;

-- 表不存在 以及排序属性字段不存在
select * from student order by score asc;
select * from person order by age asc;

# 谓词部分条件表达式校验
select * from student as s1,student as s2 where s1.age+s2.age>50 and s1.age>s2.age;

-- 校验表 属性的存在性
select * from person as s1,student as s2 where s1.age+s2.age>50 and s1.age>s2.age;

-- 校验表 数据类型是否支持符号运算
select * from student as s1,student as s2 where s1.first_name+s2.age>50 and s1.age>s2.age;

## 连接查询
# 自然连接
select s1.s_id,s2.* from student as s1,student as s2;
select s1.*,s2.* from student as s1,student as s2;
select student.s_id,course.c_id from student,course

-- 表校验失败
select s1.s_id,s2.* from person as s1,student as s2;

-- 属性校验失败
select s1.p_id,s2.* from student as s1,student as s2;
select s1.s_id,s2.*,s2.s_id from student as s1,student as s2;
select s1.s_id,s3.* from student as s1,student as s2;

# 内连接
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

-- 表不存在
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

-- 表属性错误
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

-- 出现没出现过的别名
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

-- on表达式两端类型不一致
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

# 外连接 不做

# 全连接 不做
