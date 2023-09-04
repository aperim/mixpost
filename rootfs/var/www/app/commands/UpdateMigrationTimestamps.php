<?php

namespace App\Console\Commands;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\File;
use Illuminate\Console\Command;

class UpdateMigrationTimestamps extends Command
{
    protected $signature = 'mixpost:update-migration-timestamps';
    protected $description = 'Update the migration timestamps in the database';

    public function handle()
    {
        if (!Schema::hasTable('migrations')) {
            $this->warn('`migrations` table does not exist.');
            return;
        }

        $this->info('Check migration timestamps...');

        $migrationsPath = database_path('migrations');
        $files = File::allFiles($migrationsPath);

        $migrationsInDb = DB::table('migrations')->pluck('migration')->toArray();

        foreach ($files as $file) {
            $filename = pathinfo($file, PATHINFO_BASENAME);
            preg_match('/\d{4}_\d{2}_\d{2}_\d{6}_/', $filename, $matches);
            $newTimestamp = $matches[0];

            $migrationNameWithTimestamp = str_replace('.php', '', $filename);
            $migrationName = str_replace($newTimestamp, '', $migrationNameWithTimestamp);

            $matchingMigrationInDb = preg_grep("/$migrationName$/", $migrationsInDb);

            if ($matchingMigrationInDb) {
                $oldMigrationNameWithTimestamp = reset($matchingMigrationInDb);
                $newMigrationNameWithTimestamp = $migrationNameWithTimestamp;

                if($oldMigrationNameWithTimestamp !== $newMigrationNameWithTimestamp) {
                    DB::table('migrations')
                    ->where('migration', $oldMigrationNameWithTimestamp)
                    ->update(['migration' => $newMigrationNameWithTimestamp]);

                    $this->info("Updated $oldMigrationNameWithTimestamp to $newMigrationNameWithTimestamp");
                }
            }
        }

        $this->info('DONE');
    }
}