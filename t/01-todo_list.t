#!/usr/bin/env perl
use strict;
use warnings;

use lib "lib";

use Test::More;
use File::Temp qw/tempfile/;
use App::TodoList;

my ($fh, $tempfile) = tempfile();

my $todo = TodoList->new(file => $tempfile);

my $task_count = $todo->add_task("Learn Perl");
is($task_count, 1, "Task added successfully");

$task_count = $todo->add_task("Write tests");
is($task_count, 2, "Second task added successfully");

my @tasks = $todo->list_tasks();
is(scalar @tasks, 2, "Correct number of tasks listed");
is($tasks[0]->{task}, "Learn Perl", "First task description matches");
is($tasks[0]->{completed}, 0, "First task is not completed");
is($tasks[1]->{task}, "Write tests", "Second task description matches");

ok($todo->complete_task(1), "First task marked as completed");
@tasks = $todo->list_tasks();
is($tasks[0]->{completed}, 1, "First task is now completed");

ok($todo->delete_task(1), "First task deleted successfully");
@tasks = $todo->list_tasks();
is(scalar @tasks, 1, "One task remaining after deletion");
is($tasks[0]->{task}, "Write tests", "Remaining task description matches");

ok(!$todo->complete_task(99), "Completing non-existent task returns false");
ok(!$todo->delete_task(99), "Deleting non-existent task returns false");

$todo->add_task("New Task");
undef $todo;

my $new_todo = TodoList->new(file => $tempfile);
my @new_tasks = $new_todo->list_tasks();
is(scalar @new_tasks, 2, "Tasks loaded from file correctly after reload");
is($new_tasks[1]->{task}, "New Task", "New task loaded correctly from file");

done_testing();
