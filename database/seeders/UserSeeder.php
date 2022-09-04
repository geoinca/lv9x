<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

use App\Models\User;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        // DB::table('users')->insert([
        //     'name' => Str::random(10),
        //     'email' => Str::random(10).'@gmail.com',
        //     'password' => Hash::make('password'),
        // ]);
        $user = new User();
        $user->name = 'host';
        //$user->lastname = 'host';
        $user->email = 'host@example.com';
        $user->password = bcrypt('secret');
        $user->save();
        // $user->roles()->attach($role_user);
        // $user->origens()->attach($origen_web);

        $user = new User();
        $user->name = 'guest';
        //$user->lastname = 'guest';
        $user->email = 'guest@example.com';
        $user->password = bcrypt('secret');
        $user->save();
        // $user->roles()->attach($role_admin);
        // $user->origens()->attach($origen_web);
    }
}
