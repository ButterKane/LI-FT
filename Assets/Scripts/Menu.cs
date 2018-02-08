using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Menu : MonoBehaviour {

	public GameObject menuGroup;
	public bool isMenuActivated = true;
	public GameObject Vehicule;
	public bool isGameOn = false;

	void Start()
	{
		isMenuActivated = true;
		isGameOn = false;
	}

	void update()
	{
		
	}




	public void StartClick ()

	{
		isGameOn = true;
		Vehicule.GetComponent<DumbXboxControl> ().IsGameStarted = true;
		isMenuActivated = !isMenuActivated; // le "!" signifie l'inverse de létat actuel

		menuGroup.SetActive (isMenuActivated);
	}



	public void exitGame ()
	{
		Application.Quit ();
	}




}
