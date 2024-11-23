use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'App::TodoList',
    VERSION_FROM  => 'lib/App/TodoList.pm',
    PREREQ_PM     => {
        'JSON'           => 0,
        'File::HomeDir'  => 0,
        'File::Spec'     => 0,
    },
    ABSTRACT      => 'Gerenciador de tarefas simples',
    AUTHOR        => 'Luiz Felipe de Castro Vilas Boas <luizfelipecastrovb@gmail.com>',
    LICENSE       => 'MIT',
    META_MERGE    => {
        resources => {
            repository => 'https://gitlab.com/olooeez/app-todolist',
        },
    },
    INSTALLDIRS => 'site',
    EXE_FILES   => ['script/todo'],
);
