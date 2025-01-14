const oracledb = require('oracledb');

async function listAllInformation() {
    let connection;
    try {
        connection = await oracledb.getConnection();
        const result = await connection.execute(`SELECT * FROM INFORMATION`);
        return result.rows;
    } catch (error) {
        console.error('Error fetching information:', error);
        throw error;
    } finally {
        if (connection) {
            await connection.close();
        }
    }
}

// Insert new information
async function newInformation(informationData) {
    let conn;
    try {
      conn = await oracledb.getConnection();
      console.log(informationData);
      await conn.execute(
        `INSERT INTO INFORMATION (name, lastUpdated, name1, email1, phnNum1, name2, email2, phnNum2, name3, email3, phnNum3)
        VALUES (:name, TO_DATE(:lastUpdated, 'YYYY-MM-DD"T"HH24:MI:SS'), :name1, :email1, :phnNum1, :name2, :email2, :phnNum2, :name3, :email3, :phnNum3)`,
        {
            name: informationData.name,
            lastUpdated: informationData.lastUpdated,
            name1: informationData.name1,
            email1: informationData.email1,
            phnNum1: informationData.phnNum1,
            name2: informationData.name2,
            email2: informationData.email2,
            phnNum2: informationData.phnNum2,
            name3: informationData.name3,
            email3: informationData.email3,
            phnNum3: informationData.phnNum3
        },
        { autoCommit: true }
      );
    } catch (err) {
      console.log(err);
      throw err;
    } finally {
      if (conn) {
        await conn.close();
      }
    }
}

// updateInformation
async function updateInformationByClientName(updatedData) {
  let conn;
  try {
    conn = await oracledb.getConnection(); // Establish connection to Oracle DB

    let fieldsToUpdate = [];
    let values = { name: updatedData.name }; // Bind the primary key (name)

    // Dynamically prepare fields to update based on provided data
    if (updatedData.lastUpdated) {
      fieldsToUpdate.push("lastUpdated = TO_DATE(:lastUpdated, 'YYYY-MM-DD\"T\"HH24:MI:SS')");
      values.lastUpdated = updatedData.lastUpdated;
    }
    if (updatedData.name1) {
      fieldsToUpdate.push("name1 = :name1");
      values.name1 = updatedData.name1;
    }
    if (updatedData.email1) {
      fieldsToUpdate.push("email1 = :email1");
      values.email1 = updatedData.email1;
    }
    if (updatedData.phnNum1) {
      fieldsToUpdate.push("phnNum1 = :phnNum1");
      values.phnNum1 = updatedData.phnNum1;
    }
    if (updatedData.name2) {
      fieldsToUpdate.push("name2 = :name2");
      values.name2 = updatedData.name2;
    }
    if (updatedData.email2) {
      fieldsToUpdate.push("email2 = :email2");
      values.email2 = updatedData.email2;
    }
    if (updatedData.phnNum2) {
      fieldsToUpdate.push("phnNum2 = :phnNum2");
      values.phnNum2 = updatedData.phnNum2;
    }
    if (updatedData.name3) {
      fieldsToUpdate.push("name3 = :name3");
      values.name3 = updatedData.name3;
    }
    if (updatedData.email3) {
      fieldsToUpdate.push("email3 = :email3");
      values.email3 = updatedData.email3;
    }
    if (updatedData.phnNum3) {
      fieldsToUpdate.push("phnNum3 = :phnNum3");
      values.phnNum3 = updatedData.phnNum3;
    }

    // If no fields to update, return
    if (fieldsToUpdate.length === 0) {
      throw new Error("No fields provided to update");
    }

    // Build SQL query
    const sql = `UPDATE INFORMATION SET ${fieldsToUpdate.join(", ")} WHERE name = :name`;

    // Execute the query
    const result = await conn.execute(sql, values, { autoCommit: true });
    return result;
  } catch (err) {
    console.error(err);
    throw err;
  } finally {
    if (conn) {
      await conn.close(); // Close the connection
    }
  }
}

// async function updateInformationByClientName(updatedData) {
//   console.log(updatedData);
//   let conn;
//   try {
//     conn = await oracledb.getConnection(); // Establish a connection with the Oracle database

//     let fieldsToUpdate = [];
//     let values = { co_center_id: updatedData.coCenterId }; // Bind the primary key (CO_CENTER_ID)

//     if (updatedData.coCenterName) {
//       fieldsToUpdate.push("CO_CENTER_NAME = :co_center_name");
//       values.co_center_name = updatedData.coCenterName;
//     }
//     if (updatedData.streetId) {
//       fieldsToUpdate.push("STREET_ID = :street_id");
//       values.street_id = updatedData.streetId;
//     }
//     if (updatedData.managerId) {
//       fieldsToUpdate.push("MANAGER_ID = :manager_id");
//       values.manager_id = updatedData.managerId;
//     }

//     // If no fields to update, return
//     if (fieldsToUpdate.length === 0) {
//       throw new Error("No fields provided to update");
//     }

//     const sql = `UPDATE COMMUNITY_CENTER SET ${fieldsToUpdate.join(
//       ", "
//     )} WHERE CO_CENTER_ID = :co_center_id`;

//     const result = await conn.execute(sql, values, { autoCommit: true });
//     return result;
//   } catch (err) {
//     throw err;
//   } finally {
//     if (conn) {
//       await conn.close();
//     }
//   }
// }


module.exports = {
    listAllInformation,
    newInformation,
    updateInformationByClientName,
};