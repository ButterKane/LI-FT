using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PowerupGestion : MonoBehaviour {

	public float pickupPetrole;
	public float pickupUranium;
	public float pickupEolienne;
	public float pickupCharbon;

	public GameObject Player;
	public float actualEnergyUsed;

	void Update () 
	{
		actualEnergyUsed = Player.GetComponent<DumbXboxControl> ().lastPickup;

		// Ajouter tout le code qui détruit le terrain petit à petit selon l'énergie
		// Pas oublier d'ajouter une regen au terrain.
	}
}
