<?php
include "config.php";

// Check if the renter_id parameter is set
if (isset($_POST['id'])) {
    // Sanitize and validate the renter_id parameter
    $renter_id = filter_input(INPUT_POST, 'id', FILTER_SANITIZE_NUMBER_INT);

    // Start a new transaction
    $connect->begin_transaction();

    try {
        // Delete the subrenters related to the renter_id
        $sub_query = "DELETE FROM subtransaction WHERE id = ?";
        $sub_stmt = $connect->prepare($sub_query);
        $sub_stmt->bind_param("i", $renter_id);
        $sub_stmt->execute();
        $sub_stmt->close();

       

        // Commit the transaction
        $connect->commit();

        echo "Record deleted successfully";
    } catch (Exception $e) {
        // Rollback the transaction if an error occurs
        $connect->rollback();

        echo "Error deleting record: " . $e->getMessage();
    }
} else {
    echo "Missing renter_id parameter";
}

// Close the connection
$connect->close();
?>
