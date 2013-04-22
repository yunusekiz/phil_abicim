<?php

class teacher_model extends CI_Model {


	public function insertNewTecher($teacher_name, $teacher_surname, $ss_number)
	{
		$insert_data = array(	
								'teacher_name'		=>	$teacher_name,
								'teacher_surname'	=>	$teacher_surname,
								'ss_number'			=>	$ss_number
							);

		$query = $this->db->insert('teacher', $insert_data);

		if ($this->db->affected_rows()>0)
			return TRUE;
		else
			return FALSE;
	}


}