<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PostSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('posts')->insert([
            [
                'title' => 'Selamat Datang di Aplikasi Demo',
                'content' => 'Ini adalah postingan pertama di aplikasi demo kami. Aplikasi ini menunjukkan fitur CRUD (Create, Read, Update, Delete) untuk mengelola postingan.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Cara Menggunakan Aplikasi Ini',
                'content' => 'Anda dapat membuat postingan baru dengan mengklik tombol "Create New Post". Anda juga dapat mengedit atau menghapus postingan yang sudah ada.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Fitur yang Tersedia',
                'content' => 'Aplikasi ini memiliki fitur lengkap untuk mengelola postingan, termasuk membuat, melihat, mengedit, dan menghapus postingan. Antarmuka dibuat dengan Tailwind CSS untuk tampilan yang menarik.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
