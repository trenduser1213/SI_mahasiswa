import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/cupertino.dart';

import 'package:si_mahasiswa/models/mahasiswa.dart';
import 'package:si_mahasiswa/screens/createEdit.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final searchController = TextEditingController();
  List<Mahasiswa> filteredMahasiswaList = [];
  List<Mahasiswa> _listMahasiswa = [
    // Mahasiswa(
    //   nim: "211",
    //   nama: "triandi",
    //   kelas: "d4l",
    //   prodi: "prodi",
    //   jurusan: "jurusan",
    //   fakultas: "fakultas",
    // ),
    // Mahasiswa(
    //   nim: "211",
    //   nama: "triandi2",
    //   kelas: "d4l",
    //   prodi: "prodi",
    //   jurusan: "jurusan",
    //   fakultas: "fakultas",
    // ),
  ];

  @override
  void initState() {
    super.initState();
    filteredMahasiswaList = _listMahasiswa;
  }

  // List<Mahasiswa> _listData = _listMahasiswa;
  search() {
    setState(() {
      _listMahasiswa.where(
        (mahasiswa) {
          String query = searchController.text;
          print(mahasiswa.nama.toLowerCase().contains(query.toLowerCase()));
          return mahasiswa.nama.toLowerCase().contains(query.toLowerCase());
          // ||
          //     mahasiswa.nim.toLowerCase().contains(query.toLowerCase());
        },
      ).toList();
    });
    // DMethod.printTitle('');
  }
//   void search() {
//     // ambil nilai yang diinputkan user pada searchController
//     // filter list mahasiswa berdasarkan query
//     _listMahasiswaSearched = _listMahasiswa.where((mahasiswa) {
//       return mahasiswa.nama.toLowerCase().contains(query.toLowerCase()) ||
//           mahasiswa.nim.toLowerCase().contains(query.toLowerCase());
//     }).toList();
//   });
// }

  _showPopUpMenu(BuildContext context, int index) {
    final mahasiswaClicked = _listMahasiswa[index];

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Menu untuk mahasiswa ${mahasiswaClicked.nama}'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              final result = await Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CreateEdit(
                    mode: FormMode.edit,
                    mahasiswa: mahasiswaClicked,
                  ),
                ),
              );
              if (result is Mahasiswa) {
                setState(() {
                  _listMahasiswa[index] = result;
                });
                // _saveDataToStorage();
              }
            },
            child: const Text('Edit'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                  title: const Text('Apakah anda yakin?'),
                  content: Text(
                      'Data mahasiswa ${mahasiswaClicked.nama} akan dihapus'),
                  actions: <CupertinoDialogAction>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Tidak'),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _listMahasiswa.removeAt(index);
                        });
                      },
                      child: const Text('Iya'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text("Daftar mahasiswa"),
          trailing: GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const CreateEdit(
                    mode: FormMode.create,
                  ),
                ),
              );
              if (result is Mahasiswa) {
                setState(() {
                  _listMahasiswa.add(result);
                });
              }
            },
            child: Icon(
              CupertinoIcons.add_circled_solid,
              size: 25,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: CupertinoTextField(
                  controller: searchController,
                  placeholder: 'Cari mahasiswa',
                  suffix: Container(
                    child: IconButton(
                      icon: const Icon(CupertinoIcons.search),
                      onPressed: () {
                        setState(() {
                          filteredMahasiswaList = _listMahasiswa
                              .where((mahasiswa) => mahasiswa.nama
                                  .toLowerCase()
                                  .contains(
                                      searchController.text.toLowerCase()))
                              .toList();
                          // filteredMahasiswaList.clear();
                          // filteredMahasiswaList.addAll(_listMahasiswa);
                        });
                      },
                      // () => search(),
                    ),
                  ),
                  // onChanged: () => search(),
                ),
              ),
              // Container(
              //   height: 50 - 16,
              //   margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              //   decoration: BoxDecoration(
              //     color: Colors.white10,
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: CupertinoTextField(
              //     controller: searchController,
              //     //     hintText: "search ..",
              //     // onChanged: (value) => ,
              //   ),
              //   // TextField(
              //   //   decoration: InputDecoration(
              //   //     isDense: true,
              //   //     suffixIcon: Container(
              //   //       child: IconButton(
              //   //         icon: const Icon(CupertinoIcons.add_circled_solid),
              //   //         onPressed: () => search(),
              //   //       ),
              //   //     ),
              //   //   ),
              //   // ),
              //   // onChanged: (value) {
              //   // implement search functionality here
              //   // },
              // ),
              Expanded(
                child: ListView.separated(
                  itemCount: filteredMahasiswaList.length,
                  itemBuilder: (context, index) {
                    final item = filteredMahasiswaList[index];
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: GestureDetector(
                        onTap: () => _showPopUpMenu(context, index),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${item.nama} (${item.nim})"),
                            Text(
                              "${item.kelas}/${item.jurusan}/${item.prodi}/${item.fakultas}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
