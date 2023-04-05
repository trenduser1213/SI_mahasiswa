// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:si_mahasiswa/models/mahasiswa.dart';

enum FormMode { create, edit }

class CreateEdit extends StatefulWidget {
  const CreateEdit({super.key, required this.mode, this.mahasiswa});

  final FormMode mode;
  final Mahasiswa? mahasiswa;

  @override
  State<CreateEdit> createState() => _CreateEditState();
}

class _CreateEditState extends State<CreateEdit> {
  TextEditingController _nrpController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _kelasController = TextEditingController();
  TextEditingController _jurusanController = TextEditingController();
  TextEditingController _prodiController = TextEditingController();
  TextEditingController _fakultasController = TextEditingController();

  getMahasiswa() {
    return Mahasiswa(
      nim: _nrpController.text,
      nama: _namaController.text,
      kelas: _kelasController.text,
      prodi: _prodiController.text,
      jurusan: _jurusanController.text,
      fakultas: _fakultasController.text,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.mode == FormMode.edit) {
      _nrpController.text = widget.mahasiswa!.nim;
      _namaController.text = widget.mahasiswa!.nama;
      _kelasController.text = widget.mahasiswa!.kelas;
      _prodiController.text = widget.mahasiswa!.prodi;
      _jurusanController.text = widget.mahasiswa!.jurusan;
      _fakultasController.text = widget.mahasiswa!.fakultas;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.mode == FormMode.create
            ? "Tambah Mahasiswa"
            : "Edit Mahasiswa"),
        trailing: GestureDetector(
          onTap: () {
            // if (_nrpController.text.isEmpty ||
            //     _namaController.text.isEmpty ||
            //     _kelasController.text.isEmpty ||
            //     _jurusanController.text.isEmpty ||
            //     _prodiController.text.isEmpty ||
            //     _fakultasController.text.isEmpty) {
            //   return showDialog(
            //     context: context,
            //     builder: (context) {
            //       return CupertinoAlertDialog(
            //         title: const Text("Peringatan"),
            //         content: const Text("Data Tidak Boleh Kosong"),
            //         actions: [
            //           CupertinoDialogAction(
            //             child: const Text("OK"),
            //             onPressed: () {
            //               Navigator.pop(context);
            //             },
            //           )
            //         ],
            //       );
            //     },
            //   );
            // } else {
            Navigator.pop(context, getMahasiswa());
            // }
          },
          child: Text(widget.mode == FormMode.create ? "Tambah" : "edit"),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: CupertinoFormSection(
            header: Text(widget.mode == FormMode.create
                ? 'Tambah Data Mahasiswa'
                : ' Edit Data '),
            children: [
              CupertinoFormRow(
                prefix: const Text("NRP"),
                child: CupertinoTextFormFieldRow(
                  controller: _nrpController,
                  placeholder: "Masukkan NRP",
                ),
              ),
              CupertinoFormRow(
                prefix: const Text("Nama"),
                child: CupertinoTextFormFieldRow(
                  controller: _namaController,
                  placeholder: "Masukkan Nama",
                ),
              ),
              CupertinoFormRow(
                prefix: const Text("Kelas"),
                child: CupertinoTextFormFieldRow(
                  controller: _kelasController,
                  placeholder: "Masukkan Kelas",
                ),
              ),
              CupertinoFormRow(
                prefix: const Text("Jurusan"),
                child: CupertinoTextFormFieldRow(
                  controller: _jurusanController,
                  placeholder: "Masukkan Jurusan",
                ),
              ),
              CupertinoFormRow(
                prefix: const Text("Prodi"),
                child: CupertinoTextFormFieldRow(
                  controller: _prodiController,
                  placeholder: "Masukkan Prodi",
                ),
              ),
              CupertinoFormRow(
                prefix: const Text("Fakultas"),
                child: CupertinoTextFormFieldRow(
                  controller: _fakultasController,
                  placeholder: "Masukkan Fakultas",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
