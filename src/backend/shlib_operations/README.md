Операции над разделяемыми библиотеками
======================================
Этот каталог содержит реализацию операций над динамически подгружаемыми расширениями
(например их загрузку).

Описание протокола взамиодействия основной программы с расширениями.
=======================================
1. Каталог, в котором харняться расширения: src/backend/contrib (позже можно будет указать свой в конфиге).
2. Расширение является разделяемой библиотекой (.so) и должно называться: {имя_расширения}.so (имя расширения совпадает
    с названием папки, в которой оно харнится).
3. Если раширению требуется инициализация, то оно должно содержать метод init со следующей сигнатурой:
    extern void init(void *arg, ...).
4. Если расширению требуется выполнение некоторый операций от основного процесса (например создание отдельного процесса
для себя), то оно может воспользоваться одим из указателей на функцию из структуры Boss_op_func
(backend/include/boss_operations/boss_operations.h), указатель на которую передаётся в расширение первым аргументом.
Указатели на функции валидны только в рамках выполнения функции init.
P.S. В дальнейшем протокол взаимодействия основоной программы с раширением возможно будет расширен.
