import matplotlib.pyplot as plt
# import seaborn as sns

plot_align = [4, 3]
out_put = '1.png'
X = [
	[53, 137, 23, 388, 39, 9, 503, 207, 113, 70],
	[12, 18, 6, 63, 10, 3, 117, 36, 28, 6],
	[4, 1, 1, 9, 6, 3, 10, 2, 5, 1],
	[13, 7, 7, 101, 3, 1, 31, 34, 51, 69],
	[1, 1, 1, 12, 1, 0.5, 6, 4, 4, 19],
	[0.4, 1, 1, 14, 0.4, 2, 3, 3, 5, 30],
	[21, 36, 7, 93, 22, 2, 160, 59, 26, 23],
	[7, 8, 5, 20, 13, 1, 46, 19, 9, 6],
	[0.1, 4, 1, 3, 2, 1, 6, 3, 6, 1],
	[87, 82, 7, 519, 19, 9, 291, 77, 75, 280],
	[14, 7, 1, 76, 3, 2, 67, 9, 17, 43],
	[3, 1, 1, 17, 1, 0.5, 16, 4, 3, 16]
]
legend = [
	'polar nocharge-polar negative', 
	'polar negative-nonpolar',
	'polar positive-polar positive',
	'polar nocharge-nonpolar',
	'polar positive-polar negative',
	'polar negative-polar negative',
	'nonpolar-nonpolar',
	'polar positive-nonpolar',
	'polar nocharge-polar positive',
	'polar nocharge-polar nocharge'
]

colors2 = [
	'#2F1B41', '#872341', '#BE3144', '#F05941',
	'#DDDDDD', '#574E6D', '#43405D', '#4B586E',
	'#DDE8B9', '#E8D2AE'
]
colors = [
	'#F4E7D3', '#0881A3', '#1F4E5F', '#253B6E',
	'#DDDDDD', '#574E6D', '#43405D', '#4B586E',
	'#DDE8B9', '#E8D2AE'
]


plt.figure(figsize=[20, 20])
for i in range(len(X)):
	plt.subplot(plot_align[0] + 1, plot_align[1], i+1)
	plt.axis('equal')
	plt.pie(X[i], autopct='%1.1f%%', startangle=90, colors=colors)

patches, _ = plt.pie(X[-1], startangle=90, colors=colors)
plt.subplot(plot_align[0] + 1, plot_align[1], plot_align[0] * plot_align[1] + plot_align[1] // 2 + plot_align[1] % 2)
plt.pie([])
plt.legend(patches, legend, bbox_to_anchor=(-.15, .6, 1.4, .202), loc=1,
           ncol=2, mode="expand", borderaxespad=0., fontsize=19)

plt.subplot(plot_align[0] + 1, plot_align[1], 13)
plt.pie([])
plt.title('native', fontsize=30)
plt.subplot(plot_align[0] + 1, plot_align[1], 14)
plt.pie([])
plt.title('PLM', fontsize=30)
plt.subplot(plot_align[0] + 1, plot_align[1], 15)
plt.pie([])
plt.title('mf-DI', fontsize=30)

plt.tight_layout(pad=0, w_pad=-10, h_pad=0.1)
plt.savefig(out_put)
