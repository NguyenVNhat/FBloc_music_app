import 'package:flutter/material.dart';

class AdminBlogManager extends StatelessWidget {
  const AdminBlogManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blogs = [
      {
        'id': 1,
        'title': 'Top 10 Indie Songs',
        'author': 'music_lover',
        'status': 'Published'
      },
      {
        'id': 2,
        'title': 'Billie Eilish Review',
        'author': 'popqueen',
        'status': 'Pending'
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.article, color: Colors.blueAccent, size: 32),
                SizedBox(width: 8),
                Text('Quản lý Blog',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              label:
                  const Text('Thêm mới', style: TextStyle(color: Colors.white)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => _BlogDialog(),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Tiêu đề')),
                  DataColumn(label: Text('Tác giả')),
                  DataColumn(label: Text('Trạng thái')),
                  DataColumn(label: Text('Hành động')),
                ],
                rows: blogs.map((blog) {
                  return DataRow(cells: [
                    DataCell(Text(blog['title'] as String)),
                    DataCell(Text(blog['author'] as String)),
                    DataCell(Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: (blog['status'] == 'Published')
                            ? Colors.green[100]
                            : Colors.orange[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(blog['status'] as String,
                          style: TextStyle(
                              color: (blog['status'] == 'Published')
                                  ? Colors.green
                                  : Colors.orange)),
                    )),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => _BlogDialog(blog: blog),
                            );
                          },
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Xác nhận xóa'),
                                content: const Text(
                                    'Bạn có chắc muốn xóa blog này?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Hủy'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text('Đã xóa blog!')));
                                    },
                                    child: const Text('Xóa'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BlogDialog extends StatelessWidget {
  final Map<String, Object>? blog;
  const _BlogDialog({this.blog});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(blog == null ? 'Thêm Blog' : 'Sửa Blog',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Tiêu đề', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Tác giả', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: blog != null ? blog!['status'] as String : 'Published',
              items: const [
                DropdownMenuItem(value: 'Published', child: Text('Published')),
                DropdownMenuItem(value: 'Pending', child: Text('Pending')),
              ],
              decoration: const InputDecoration(
                  labelText: 'Trạng thái', border: OutlineInputBorder()),
              onChanged: (v) {},
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Hủy'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(blog == null
                              ? 'Đã thêm blog!'
                              : 'Đã cập nhật blog!')),
                    );
                  },
                  child: Text(blog == null ? 'Thêm' : 'Lưu'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
