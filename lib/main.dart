import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const Color warnaUtama = Color(0xFF6558C3);
const Color warnaLatar = Color(0xFFF4F2FA);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Registrasi',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: warnaUtama,
        ),
        scaffoldBackgroundColor: warnaLatar,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFDAD7E2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: warnaUtama,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
      home: const HalamanRegistrasi(),
    );
  }
}

class HalamanRegistrasi extends StatefulWidget {
  const HalamanRegistrasi({super.key});

  @override
  State<HalamanRegistrasi> createState() =>
      _HalamanRegistrasiState();
}

class _HalamanRegistrasiState extends State<HalamanRegistrasi> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  // FocusNode untuk perpindahan fokus antarkolom.
  final FocusNode _namaFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String? _jenisKelamin;
  String? _programStudi;
  bool _setujuSyarat = false;
  bool _passwordTerlihat = false;

  final List<String> _daftarProgramStudi = [
    'Sistem Informasi',
    'Informatika',
    'Manajemen',
    'Akuntansi',
    'Teknik Industri',
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    _namaFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }

  void _daftar() {
    // Periksa seluruh validasi pada Form.
    final bool formValid =
        _formKey.currentState!.validate();

    // Checkbox diperiksa terpisah sesuai instruksi dosen.
    if (!_setujuSyarat) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Silakan setujui Syarat & Ketentuan terlebih dahulu.',
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!formValid) {
      return;
    }

    // Tampilkan dialog sebelum data dikonfirmasi.
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          icon: const Icon(
            Icons.verified_user_outlined,
            color: warnaUtama,
            size: 34,
          ),
          title: const Text(
            'Konfirmasi Registrasi',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Periksa kembali data registrasi kamu:',
                ),
                const SizedBox(height: 20),
                _barisRingkasan(
                  'Nama Lengkap',
                  _namaController.text.trim(),
                ),
                _barisRingkasan(
                  'Email',
                  _emailController.text.trim(),
                ),
                _barisRingkasan(
                  'Jenis Kelamin',
                  _jenisKelamin!,
                ),
                _barisRingkasan(
                  'Program Studi',
                  _programStudi!,
                ),
                _barisRingkasan(
                  'Persetujuan',
                  'Disetujui',
                ),
                const SizedBox(height: 12),
                const Text(
                  'Password tidak ditampilkan demi keamanan.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Periksa Lagi'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: warnaUtama,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Registrasi berhasil dikonfirmasi!',
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  Widget _barisRingkasan(String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 112,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              nilai,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Registrasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: warnaUtama,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 520,
              ),
              child: Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: const BoxDecoration(
                              color: Color(0xFFECE8FF),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person_add_alt_1,
                              color: warnaUtama,
                              size: 38,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Center(
                          child: Text(
                            'Buat Akun Baru',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            'Lengkapi data di bawah untuk mendaftar.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // 1. Nama Lengkap
                        const Text(
                          'Nama Lengkap',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _namaController,
                          focusNode: _namaFocus,
                          textInputAction: TextInputAction.next,
                          textCapitalization:
                              TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Masukkan nama lengkap',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Nama lengkap wajib diisi';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_emailFocus);
                          },
                        ),

                        const SizedBox(height: 20),

                        // 2. Email
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocus,
                          keyboardType:
                              TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'contoh@email.com',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Email wajib diisi';
                            }
                            if (!value.contains('@')) {
                              return 'Email harus mengandung @';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocus);
                          },
                        ),

                        const SizedBox(height: 20),

                        // 3. Password
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          obscureText: !_passwordTerlihat,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: 'Minimal 6 karakter',
                            prefixIcon:
                                const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              tooltip: _passwordTerlihat
                                  ? 'Sembunyikan password'
                                  : 'Tampilkan password',
                              icon: Icon(
                                _passwordTerlihat
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordTerlihat =
                                      !_passwordTerlihat;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty) {
                              return 'Password wajib diisi';
                            }
                            if (value.length < 6) {
                              return 'Password minimal 6 karakter';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            _passwordFocus.unfocus();
                          },
                        ),

                        const SizedBox(height: 24),

                        // 4. Jenis Kelamin (Radio)
                        const Text(
                          'Jenis Kelamin',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RadioGroup<String>(
                          groupValue: _jenisKelamin,
                          onChanged: (value) {
                            setState(() {
                              _jenisKelamin = value;
                            });
                          },
                          child: const Column(
                            children: [
                              RadioListTile<String>(
                                value: 'Laki-laki',
                                title: Text('Laki-laki'),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                              ),
                              RadioListTile<String>(
                                value: 'Perempuan',
                                title: Text('Perempuan'),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // 5. Program Studi (Dropdown)
                        const Text(
                          'Program Studi',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _programStudi,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            hintText: 'Pilih Program Studi',
                            prefixIcon:
                                Icon(Icons.school_outlined),
                          ),
                          items: _daftarProgramStudi.map((program) {
                            return DropdownMenuItem<String>(
                              value: program,
                              child: Text(program),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _programStudi = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Pilih program studi terlebih dahulu';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // 6. Persetujuan (Checkbox)
                        Container(
                          decoration: BoxDecoration(
                            color: warnaLatar,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CheckboxListTile(
                            value: _setujuSyarat,
                            controlAffinity:
                                ListTileControlAffinity.leading,
                            contentPadding:
                                const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            title: const Text(
                              'Saya setuju dengan Syarat & Ketentuan',
                              style: TextStyle(fontSize: 14),
                            ),
                            subtitle: const Text(
                              'Pastikan data yang dimasukkan benar.',
                              style: TextStyle(fontSize: 12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _setujuSyarat = value ?? false;
                              });
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Tombol Daftar
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: FilledButton.icon(
                            onPressed: _daftar,
                            icon: const Icon(
                              Icons.person_add_alt_1,
                            ),
                            label: const Text(
                              'Daftar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: FilledButton.styleFrom(
                              backgroundColor: warnaUtama,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Center(
                          child: Text(
                            'Praktikum Mobile Programming • T4',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}