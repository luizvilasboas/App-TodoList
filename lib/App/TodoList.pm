package TodoList;

use strict;
use warnings;

use JSON;
use File::HomeDir;
use File::Spec;

our $VERSION = '0.1.0'; 

sub new {
    my ($class, %args) = @_;

    my $home_dir = File::HomeDir->my_home;
    my $file = File::Spec->catfile($home_dir, '.tasks.json');

    my $self = {
        file  => $args{file} || $file,
        tasks => [],
    };

    bless $self, $class;

    $self->_load_tasks();
    return $self;
}

sub add_task {
    my ($self, $task) = @_;
    push @{ $self->{tasks} }, { task => $task, completed => 0 };
    $self->_save_tasks();
    return scalar @{ $self->{tasks} };
}

sub list_tasks {
    my ($self) = @_;
    return @{ $self->{tasks} };
}

sub complete_task {
    my ($self, $index) = @_;
    return 0 if $index < 1 || $index > scalar @{ $self->{tasks} };
    $self->{tasks}->[$index - 1]->{completed} = 1;
    $self->_save_tasks();
    return 1;
}

sub delete_task {
    my ($self, $index) = @_;
    return 0 if $index < 1 || $index > scalar @{ $self->{tasks} };
    splice @{ $self->{tasks} }, $index - 1, 1;
    $self->_save_tasks();
    return 1;
}

sub _load_tasks {
    my ($self) = @_;
    if (-e $self->{file}) {
        open my $fh, '<', $self->{file} or die "Could not open file '$self->{file}': $!";
        local $/;
        my $json = <$fh>;
        close $fh;
        $self->{tasks} = decode_json($json) if $json;
    }
}

sub _save_tasks {
    my ($self) = @_;
    open my $fh, '>', $self->{file} or die "Could not open file '$self->{file}': $!";
    print $fh encode_json($self->{tasks});
    close $fh;
}

=head1 NAME

TodoList - A simple module for managing tasks in a to-do list.

=head1 VERSION

Version 0.1.0

=head1 SYNOPSIS

    use TodoList;

    # Create a new TodoList object (tasks are stored in .tasks.json by default)
    my $todo = TodoList->new();

    # Add a task to the list
    my $task_count = $todo->add_task("Buy milk");

    # List all tasks
    my @tasks = $todo->list_tasks();

    # Complete a task by its index
    $todo->complete_task(1);

    # Delete a task by its index
    $todo->delete_task(1);

=head1 DESCRIPTION

The C<TodoList> module provides a simple interface for managing tasks in a to-do list.
It allows the creation of tasks, marking them as completed, and deleting tasks.
Tasks are stored in a JSON file, which is loaded from and saved back to the user's home directory by default.

=head2 Methods

=head3 new

    my $todo = TodoList->new();

Creates a new C<TodoList> object. Optionally, you can specify the file to store tasks in via the C<file> parameter. By default, the tasks are stored in a file called C<.tasks.json> in the user's home directory.

=head3 add_task

    my $task_count = $todo->add_task("Buy milk");

Adds a new task to the list. Returns the total number of tasks in the list after adding the new task.

=head3 list_tasks

    my @tasks = $todo->list_tasks();

Returns a list of all tasks. Each task is represented as a hash with keys C<task> and C<completed>.

=head3 complete_task

    $todo->complete_task($index);

Marks the task at the specified C<index> as completed (C<completed => 1>). Returns 1 if the task was successfully marked as completed, or 0 if the index is invalid.

=head3 delete_task

    $todo->delete_task($index);

Deletes the task at the specified C<index>. Returns 1 if the task was successfully deleted, or 0 if the index is invalid.

=head1 PRIVATE METHODS

=head3 _load_tasks

    $self->_load_tasks();

Loads tasks from the specified file (C<.tasks.json> by default). If the file exists and contains valid JSON, the tasks are decoded into an array of task hashes.

=head3 _save_tasks

    $self->_save_tasks();

Saves the current list of tasks to the specified file (C<.tasks.json> by default) in JSON format.

=head1 AUTHOR

Your Name <your.email@example.com>

=head1 LICENSE

This module is released under the MIT License. See the LICENSE file for more details.

=cut

1;
