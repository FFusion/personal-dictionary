<?php

if ($_GET['act'] == 'addWord') {

    // Получаем json строку
    $json = file_get_contents('php://input');

    //Принимаем закодированную в JSON строку и преобразуем ее в переменную PHP.
    $obj = json_decode($json);

    addWord($obj->words);
}

if ($_GET['act'] == 'addGroup') {
    $json = file_get_contents('php://input');
    $obj = json_decode($json);

    addGroup($obj->group);
}

if ($_GET['act'] == 'getAll') {
    getAll();
}

if ($_GET['act'] == 'getWords') {
    getWords();
}

if ($_SERVER['REQUEST_METHOD'] == 'DELETE') {
   var_dump(44);
}

function connection() {
    // подключаемся к бд
    $link = mysqli_connect("localhost", "root", "", "lexicon") or die (mysql_error ());
    // указываем кодировку
    mysqli_set_charset($link, "utf8");

    return $link;
}

// Добавление слова
function addWord($word) {

    $link = connection();

    $groupId = $word->group->id;

	// Построение SQL-оператора
    $sql = "INSERT INTO words (rus,eng,group_id) VALUES ('$word->rus', '$word->eng', '$groupId')";

	// SQL-оператор выполняется
    $result = mysqli_query($link, $sql) or die (mysql_error());

    if ($result) {
        echo 'Слово добавлено';
    } else {
        echo 'Произошла ошибка';
    }

	// Закрытие соединения
    mysqli_close($link);
}


// Добавление группы
function addGroup($group) {

    $link = connection();

    // Построение SQL-оператора
    $sql = "INSERT INTO groups (name) VALUES ('$group->name')";

    // SQL-оператор выполняется
    $result = mysqli_query($link, $sql) or die (mysql_error());

    if ($result) {
        echo 'Группа добавлена';
    } else {
        echo 'Произошла ошибка';
    }

    // Закрытие соединения
    mysqli_close($link);
}

function getAll() {
    $link = connection();
    // Получаем список групп
    $sql = "SELECT groups.id, groups.name FROM groups";
    $resultQueryGroup = mysqli_query($link, $sql) or die (mysql_error());
    $data = array();



    // Смотрим число строк
    if (mysqli_num_rows($resultQueryGroup) > 0) {
        // обрабатываем каждую строку из Select выборки
        while($row = mysqli_fetch_assoc($resultQueryGroup)) {
            $row['words'] = array();
            array_push($data, $row);
        }

        // Получаем список слов
        $sql = "SELECT words.id, words.group_id, words.eng, words.rus, words.trans FROM words";
        $resultQueryWords = mysqli_query($link, $sql) or die (mysql_error());
        $words = array();

        while($row = mysqli_fetch_assoc($resultQueryWords)) {
            array_push($words, $row);
        }


        // Сортируем слова по группам
        foreach($data as $key => $group) {
            foreach($words as $word) {
                if ($group['id'] == $word['group_id']) {
                    array_push($data[$key]['words'], $word);
                }
            }
        }

        echo json_encode($data);
    } else {
        echo "Добавьте группы и слова";
    }

    mysqli_close($link);
}


function getWords() {
    $link = connection();


    // Получаем список слов
    $sql = "SELECT words.id, words.eng, words.rus, words.trans FROM words";
    $resultQueryWords = mysqli_query($link, $sql) or die (mysql_error());
    $words = array();

    while($row = mysqli_fetch_assoc($resultQueryWords)) {
        array_push($words, $row);
    }

    echo json_encode($words);

}

?>