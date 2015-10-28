运行本程序：
python human_cerevisiae_ppi.py

===========================================================

注：运行本程序需要Python环境！
Linux下自带Python环境及numpy，matplotlib等工具库。
Windows下需要依次安装python，numpy，scipy，matplotlib等程序。

另：本程序有关AUC的计算代码来自于
https://github.com/scikit-learn/scikit-learn/blob/master/sklearn/metrics/ranking.py

===========================================================

程序说明：
4-7：	导入需要用到的库
10-26：	定义全局变量及常量
28-53：	导入序列数据及训练集
55-158：函数定义
	getFactor 提取特征值
	fourierTransform 维度转换
	getX 每一对蛋白质的特征向量相乘后的向量X
	fisher Fisher 判别法
	score 给训练数据打分
	normalizeScore 将特征向量映射到（0，100）之间
	evaluate 计算准确度
	ROC 绘制ROC曲线
	AUC 计算ROC曲线的面积
158-183：主程序，调用各函数，输出结果